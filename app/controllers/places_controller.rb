class PlacesController < ApplicationController
  include ChartSystem
  before_filter :login_required

  auto_complete_for :place, :title

  # GET /places
  # GET /places.xml
  def index
    @text = 'List of places'
    @places = Place.paginate(
                               :page => params[:page],
                               :per_page => PER_PAGE,
                               :order => 'created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @places}
    end
  end

  # GET /places/1
  # GET /places/1.xml
  def show
    @place = Place.find(params[:id])
    @computers = Computer.list_for_place(@place.id)
    @screens = Screen.list_for_place(@place.id)
    @printers = Printer.list_for_place(@place.id)
    @text = @place.title

    render :action => "show", :layout => "primary-content"
  end

  # GET /places/new
  # GET /places/new.xml
  def new
    @place = Place.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @place }
    end
  end

  # GET /places/1/edit
  def edit
    @place = Place.find(params[:id])
  end

  # POST /places
  # POST /places.xml
  def create
    @place = Place.new(params[:place])

    respond_to do |format|
      if @place.save
        flash[:notice] = 'Place was successfully created.'
        format.html { redirect_to(@place) }
        format.xml  { render :xml => @place, :status => :created, :location => @place }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /places/1
  # PUT /places/1.xml
  def update
    @place = Place.find(params[:id])

    respond_to do |format|
      if @place.update_attributes(params[:place])
        flash[:notice] = 'Place was successfully updated.'
        format.html { redirect_to(@place) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.xml
  def destroy
    @place = Place.find(params[:id])
    @place.destroy

    respond_to do |format|
      format.html { redirect_to(places_url) }
      format.xml  { head :ok }
    end
  end

  def search
    if not params[:place][:title].nil?
      @places = Place.find(:all,
                           :conditions => [ 'LOWER(title) LIKE ?',
                                            '%' + params[:place][:title].downcase + '%' ],
                           :order => 'title ASC',
                           :limit => 8)
    end
  end

  def list
    case params[:places]
    when 'all'
      @places = Place.paginate(:page => params[:page],
                               :per_page => PER_PAGE,
                               :order => 'created_at DESC')
    when 'stores'
      @places = Place.stores
      @text = 'List of stores'
    when 'offices'
      @places = Place.offices
      @text = 'List of offices'
    when 'rooms'
      @places = Place.rooms
      @text = 'List of rooms'
    when 'departments'
      @places = Place.departments
      @text = 'List of departments'
    end
  end

  def stats
    google_chart([Place.departments.count,
                  Place.offices.count,
                  Place.stores.count,
                  Place.rooms.count],
                 [t('places.departments'),
                  t('places.offices'),
                  t('places.stores'),
                  t('places.rooms')
                 ],
                 Place.find(:all).count,
                 'chart', t('places.graphic_stats_paragraph'))
  end


end
