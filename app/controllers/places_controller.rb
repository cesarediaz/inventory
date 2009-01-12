class PlacesController < ApplicationController
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
    @text = @place.title

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @place }
    end
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
    @all = Place.find(:all)
    @all = @all.count

    @departments = Place.departments.count
    @offices = Place.offices.count
    @stores = Place.stores.count
    @rooms = Place.rooms.count

    if @all > 0
      @p_r = (@rooms * 100) / @all
      @p_d = (@departments * 100) / @all
      @p_s = (@stores * 100) / @all
      @p_o = (@offices * 100) / @all

      @chart = GoogleChart.new
      @chart.type = :pie_3d
      @chart.data = [@rooms, @departments, @stores, @offices]
      @chart.colors = '346000'
      @chart.labels = ["Rooms " + @p_r.to_s + '%',
                       "Department " + @p_d.to_s + '%',
                       "Store " + @p_s.to_s + '%',
                       "Office " + @p_o.to_s + '%']
    end
  end


end
