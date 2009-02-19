require 'spreadsheet/excel'
include Spreadsheet

class WorkstationsController < ApplicationController
  include ChartSystem
  include ReportSystem

  before_filter :login_required

  # GET /workstations
  # GET /workstations.xml
  def index
    hardware_in_place
    @workstations = Workstation.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @workstations }
    end
  end

  # GET /workstations/1
  # GET /workstations/1.xml
  def show
    @workstation = Workstation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @workstation }
    end
  end

  # GET /workstations/new
  # GET /workstations/new.xml
  def new
    hardware_in_place
    @workstation = Workstation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @workstation }
    end
  end

  # GET /workstations/1/edit
  def edit
    hardware_in_place
    @workstation = Workstation.find(params[:id])
  end

  # POST /workstations
  # POST /workstations.xml
  def create
    hardware_in_place
    @workstation = Workstation.new(params[:workstation])

    respond_to do |format|
      if @workstation.save
        flash[:notice] = 'Workstation was successfully created.'
        format.html { redirect_to(workstations_url) }
        format.xml  { render :xml => @workstation, :status => :created, :location => @workstation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @workstation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /workstations/1
  # PUT /workstations/1.xml
  def update
    @workstation = Workstation.find(params[:id])

    respond_to do |format|
      if @workstation.update_attributes(params[:workstation])
        flash[:notice] = 'Workstation was successfully updated.'
        format.html { redirect_to(@workstation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @workstation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /workstations/1
  # DELETE /workstations/1.xml
  def destroy
    @workstation = Workstation.find(params[:id])
    @workstation.destroy

    respond_to do |format|
      format.html { redirect_to(workstations_url) }
      format.xml  { head :ok }
    end
  end

  def stats
    hardware_in_place
    if not params[:place_id].nil?
      chart('Printer', params[:place_id],'chart_printer', @computers)
      chart('Computer', params[:place_id],'chart_computer', @printers)
      chart('Screen', params[:place_id],'chart_screen', @screens)
    end
  end

  def xls_workstations
    xls_report_workstations('/public/xls/' + t('menu.workstations') + '.xls',
                            params[:id].nil? ? 'find' : params[:id],
                            params[:id].nil? ? '(:all)' : '(' + params[:id] + ')',
                            "[t('computers.title') + ' ' + t('computers.name'), 'ip', 'mac',
                              t('screens.title') + ' ' + t('screens.model'), t('screens.sn'),
                              t('printers.title') + ' ' + t('printers.model'), t('printers.sn'),
                              t('places.title')]"
                            )
  end

  private

  def hardware_in_place
    @place_name = Place.find(params[:place_id]).title rescue nil
    @place_id = params[:place_id] rescue nil

    @places = Place.all
    @computers = Computer.list_for_place_are_not_part_a_workstation(params[:place_id])
    @screens = Screen.list_for_place_are_not_part_a_workstation(params[:place_id])
    @printers = Printer.list_for_place_are_not_part_a_workstation(params[:place_id])
  end

  def chart(element, place, chart_type, number)
    eval %"

      google_chart([#{element}.list_for_place_are_not_part_a_workstation(#{place}).count,
                    #{element}.list_for_place_as_part_a_workstation(#{place}).count],
                   [t('stats.alone'), t('stats.workstation')],
                   #{element}.list_for_place_are_not_part_a_workstation(#{place}).count +
                   #{element}.list_for_place_as_part_a_workstation(#{place}).count,
                   chart_type, t('workstations.#{element.downcase}'))

    ";
  end

end
