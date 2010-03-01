# This file is part of Hardware Inventory.
#
#     Copyright (C) 2009 Cesar Diaz
#
#     Hardware Inventory is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     any later version.
#
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with this program. If not, see <http://www.gnu.org/licenses/>.

require 'pdf/writer'
require 'pdf/simpletable'

require 'spreadsheet/excel'
include Spreadsheet

INCLUDE_PLACE = [:screen, :printer]
INCLUDE_MARK = [:mark]
INCLUDE_IN_COMPUTER = [:place, :memory, :harddisk, :cd, :dvd, :mother_board]

class PlacesController < ApplicationController
  include ChartSystem
  include ReportSystem
  include PdfReportSystem

  protect_from_forgery :only => [:create, :update, :destroy]

  before_filter :login_required
  auto_complete_for :place, :title

  # GET /places
  # GET /places.xml
  def index
    flash[:notice] = t('phrases.list_of') + t('menu.places').downcase
    @places = Place.paginate(
                             :page => params[:page],
                             :per_page => PER_PAGE,
                             :order => 'created_at DESC',
                             :include => INCLUDE_PLACE
                             )
  end

  # GET /places/1
  # GET /places/1.xml
  def show
    @place = Place.find(params[:id], :select => 'id, title')
    @computers = Computer.list_for_place(@place.id).paginate(
                               :page => params[:page],
                               :per_page => PER_PAGE,
                               :include => INCLUDE_IN_COMPUTER,
                               :order => 'created_at DESC')
    @screens = Screen.list_for_place(@place.id).paginate(
                               :page => params[:page],
                               :per_page => PER_PAGE,
                               :include => INCLUDE_MARK,
                               :order => 'created_at DESC')
    @printers = Printer.list_for_place(@place.id).paginate(
                               :page => params[:page],
                               :per_page => PER_PAGE,
                               :include => INCLUDE_MARK,
                               :order => 'created_at DESC')
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
               "[t('places.title'), t('places.description'), t('places.computer'),
                 t('places.screen'), t('places.printer'), t('places.workstations')]",
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
      flash[:notice] = t('phrases.list_of') + t('menu.places').downcase
      redirect_to(:controller => 'places', :action => 'index')
    when 'stores'
      @places = Place.stores
      flash[:notice] = t('phrases.list_of') + t('places.stores').downcase

    when 'offices'
      @places = Place.offices
      flash[:notice] = t('phrases.list_of') + t('places.offices').downcase
    when 'rooms'
      @places = Place.rooms
      flash[:notice] = t('phrases.list_of') + t('places.rooms').downcase
    when 'classrooms'
      @places = Place.classrooms
      flash[:notice] = t('phrases.list_of') + t('places.classrooms').downcase
    when 'departments'
      @places = Place.departments
      flash[:notice] = t('phrases.list_of') + t('places.departments').downcase
    end
  end

  def stats
    flash[:notice] = t('stats.places_statistic')
    @graph = open_flash_chart_object(750,700,"/places/graph_types_places/show")
    @computers_by_place = open_flash_chart_object(750,700,"/places/graph_computers_by_place/show")
    @printers_by_place = open_flash_chart_object(750,700,"/places/graph_printers_by_place/show")
    @screens_by_place = open_flash_chart_object(750,700,"/places/graph_screens_by_place/show")
    render :layout => "primary-content"

  end

  def graph_types_places
    pie_values
    title = Title.new(t('places.graphic_stats_paragraph'))

    pie = Pie.new
    pie.start_angle = 35
    pie.animate = true
    pie.tooltip = '#val# de #total#<br>#percent# del 100%'
    pie.colours = [generateUniqueHexCode( 6 ),
                   generateUniqueHexCode( 6 ),
                   generateUniqueHexCode( 6 ),
                   generateUniqueHexCode( 6 )]
    pie.values  = @pie_values

    chart = OpenFlashChart.new
    chart.title = title
    chart.add_element(pie)
    chart.bg_colour="#FFFFFF"
    chart.x_axis = nil
    render :text => chart.to_s
  end

  def graph_computers_by_place
    pie_values_computers_by_place

    title = Title.new(t('places.computer'))

    pie = Pie.new
    pie.start_angle = 35
    pie.animate = true
    pie.tooltip = '#val# de #total#<br>#percent# del 100%'
    pie.colours = @colors
    pie.values  =  @pie_values_computers_by_place

    chart = OpenFlashChart.new
    chart.title = title
    chart.add_element(pie)
    chart.bg_colour="#FFFFFF"
    chart.x_axis = nil
    render :text => chart.to_s

  end

  def graph_printers_by_place
    pie_values_printers_by_place

    title = Title.new(t('places.printer'))

    pie = Pie.new
    pie.start_angle = 35
    pie.animate = true
    pie.tooltip = '#val# de #total#<br>#percent# del 100%'
    pie.colours = @colors
    pie.values  =  @pie_values_printers_by_place

    chart = OpenFlashChart.new
    chart.title = title
    chart.add_element(pie)
    chart.bg_colour="#FFFFFF"
    chart.x_axis = nil
    render :text => chart.to_s

  end

  def graph_screens_by_place
    pie_values_screens_by_place

    title = Title.new(t('places.screen'))

    pie = Pie.new
    pie.start_angle = 35
    pie.animate = true
    pie.tooltip = '#val# de #total#<br>#percent# del 100%'
    pie.colours =  @colors
    pie.values  =  @pie_values_screens_by_place

    chart = OpenFlashChart.new
    chart.title = title
    chart.add_element(pie)
    chart.bg_colour="#FFFFFF"
    chart.x_axis = nil
    render :text => chart.to_s

  end

  def pdf
    pdf_report(Place.find(:all),
               "A4",
               t('common_actions.report_of') + t('menu.places'),
               15,
               ["col1", "col2", "col3", "col4", "col5", "col6"],
               'places'
               )
  end


  private

  def pie_values
    @pie_values = []
    if not Place.departments.empty?
      @pie_values << PieValue.new(Place.departments.count,t('places.departments') \
                                  + '('+ Place.departments.count.to_s + ')')
    end

    if not Place.offices.empty?
      @pie_values << PieValue.new(Place.offices.count,t('places.offices') \
                                  + '('+ Place.offices.count.to_s + ')')
    end

    if not Place.stores.empty?
      @pie_values << PieValue.new(Place.stores.count,t('places.stores') \
                                  + '('+ Place.stores.count.to_s + ')')
    end

    if not Place.rooms.empty?
      @pie_values << PieValue.new(Place.rooms.count, t('places.rooms') \
                                  + '('+ Place.rooms.count.to_s + ')')
    end
  end

  def pie_values_computers_by_place
    @pie_values_computers_by_place = []
    @colors = []

    Place.find(:all).collect { |x|
      if not x.computer.count == 0
        @pie_values_computers_by_place << PieValue.new(x.computer.count, x.title.to_s \
                                                         + '('+ x.computer.count.to_s + ')')
        @colors << generateUniqueHexCode( 6 )
      end
    }

  end

  def pie_values_printers_by_place
    @pie_values_printers_by_place = []
    @colors = []
    Place.find(:all).collect { |x|
      if not x.printer.count == 0
        @pie_values_printers_by_place << PieValue.new(x.printer.count, x.title.to_s \
                                                         + '('+ x.printer.count.to_s + ')')
        @colors << generateUniqueHexCode( 6 )
      end
    }

  end

  def pie_values_screens_by_place
    @pie_values_screens_by_place = []
    @colors = []
    Place.find(:all).collect { |x|
      if not x.screen.count == 0
        @pie_values_screens_by_place << PieValue.new(x.screen.count, x.title.to_s \
                                                       + '('+ x.screen.count.to_s + ')')
        @colors << generateUniqueHexCode( 6 )
      end
    }

  end


end
