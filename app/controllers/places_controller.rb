require 'spreadsheet/excel'
include Spreadsheet

class PlacesController < ApplicationController
  include ChartSystem
  include ReportSystem
  include SearchSystem

  before_filter :login_required
  auto_complete_for :place, :title

  # GET /places
  # GET /places.xml
  def index
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
    @name_of_place = @place.title
    render :action => "show", :layout => "primary-content"
  end

  # GET /places/new
  # GET /places/new.xml
  def new
    @place = Place.new

    respond_to do |format|
      format.html { render :action => "new", :layout => "primary-content"}
      format.xml  { render :xml => @place }
    end
  end

  # GET /places/1/edit
  def edit
    @place = Place.find(params[:id])
    render :action => "edit", :layout => "primary-content"
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
        format.html { render :action => "new", :layout => "primary-content" }
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
        format.html { render :action => "edit", :layout => "primary-content" }
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
      search_by('places', 'Place', params[:place][:title], 'title', 10)
    end
  end


  def xls_places
    xls_report('/public/xls/' + t('menu.places') + '.xls',
               'places',
               'Place',
               'places',
               "['title', 'description', 'computers', 'screens', 'printers']",
               params[:places].nil? ? 'find' : params[:places],
               params[:places].nil? ? '(:all)' : '(' + params[:id] + ')'
               )
  end

  def xls_computers
    xls_report('/public/xls/' +
               t('places.computer') +
               '_' +
               Place.find(params[:id]).title  +
               '.xls',
               'computers',
               'Computer',
               'computers',
               "[t('computers.name'),'mac','ip',t('computers.workstation?'),
                 'montherboard', 'harddisk', 'memory', 'cds', 'dvds']",
               "list_for_place",
               '(' + params[:id] + ')'
               )
  end

  def all_hardware

       xls_report_complete_for_a_place('/public/xls/' +
               'hardware ' +
               Place.find(params[:id]).title  +
               '.xls',
               "list_for_place",
               '(' + params[:id] + ')',
               "[t('computers.name'),'mac','ip',t('computers.workstation?'),
               'montherboard', 'harddisk', 'memory', 'cds', 'dvds']"
               )
  end

  def xls_printers
    xls_report('/public/xls/' +
               t('places.printer') +
               '_' +
               Place.find(params[:id]).title  +
               '.xls',
               'printers',
               'Printer',
               'printers',
               "['model', 'serial number']",
               "list_for_place",
               '(' + params[:id] + ')'
               )
  end

  def xls_screens
    xls_report('/public/xls/' +
               t('places.screen') +
               '_' +
               Place.find(params[:id]).title  +
               '.xls',
               'screens',
               'Screen',
               'screens',
               "['model', 'serial number']",
               "list_for_place",
               '(' + params[:id] + ')'
               )
  end


  def list
    case params[:places]
    when 'all'
      @places = Place.paginate(:page => params[:page],
                               :per_page => PER_PAGE,
                               :order => 'created_at DESC')
    when 'stores'
      @places = Place.stores
    when 'offices'
      @places = Place.offices
    when 'rooms'
      @places = Place.rooms
    when 'departments'
      @places = Place.departments
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
