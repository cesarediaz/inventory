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

INCLUDE_COMPUTER = [:place, :memory, :harddisk, :cd, :dvd, :mother_board]

class ComputersController < ApplicationController
  include ReportSystem
  include ChartSystem
  include PdfReportSystem

  before_filter :login_required

  auto_complete_for :computer, :name
  auto_complete_for :computer, :ip
  auto_complete_for :computer, :mac

  def index
    @computers = all_computers
    flash[:notice] = t('computers.title')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @computers }
    end
  end


  def available
    @computers = availables_computers
    flash[:notice] = t('phrases.list_of') + ' ' + t('places.computer') + ' ' + t('computers.available')
    respond_to do |format|
      format.html { render :action => "available", :layout => "primary-content" }
      format.xml  { render :xml => @computers }
    end
  end

  def unavailable
    @computers = unavailables_computers
    flash[:notice] = t('phrases.list_of') + ' ' + t('places.computer') + ' ' + t('computers.unavailable')
    respond_to do |format|
      format.html { render :action => "unavailable", :layout => "primary-content" }
      format.xml  { render :xml => @computers }
    end
  end

  def show
    @computer = Computer.find(params[:id])
    flash[:notice] = t('menu.computers')
    respond_to do |format|
      format.html { render :action => "show", :layout => "primary-content" }
      format.xml  { render :xml => @computer }
    end
  end

  def new
    @computer = Computer.new
    render :layout => "primary-content"
  end

  def edit
    @computer = Computer.find(params[:id])
    render  :layout => "primary-content"
  end

  def create
    @computer = Computer.new(params[:computer])

    respond_to do |format|
      if @computer.save
        created_by(self.controller_name, self.action_name, current_user.login, params[:computer])
        flash[:notice] = t('common_actions.successfully')
        format.html { redirect_to(@computer) }
        format.xml  { render :xml => @computer, :status => :created, :location => @computer }
      else
        format.html { render :action => "new", :layout => "primary-content" }
        format.xml  { render :xml => @computer.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @computer = Computer.find(params[:id])

    respond_to do |format|
      if @computer.update_attributes(params[:computer])
        update_done_by(self.controller_name, self.action_name, current_user.login, params[:computer])
        flash[:notice] = t('common_actions.successfully')
        format.html { redirect_to(@computer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit", :layout => "primary-content" }
        format.xml  { render :xml => @computer.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @computer = Computer.find(params[:id])
    deleted_by(self.controller_name, self.action_name, current_user.login, @computer.name)
    @computer.destroy

    respond_to do |format|
      format.html { redirect_to(computers_url) }
      format.xml  { head :ok }
    end
  end

  def search
    if not params[:computer][:name].nil?
      search_by('computers', 'Computer', params[:computer][:name], 'name', 10)
      flash[:notice] = t('phrases.result_search') + t('phrases.by') + t('computers.name')
    end

    if not params[:computer][:ip].nil?
      search_by('computers', 'Computer', params[:computer][:ip], 'ip', 10)
      flash[:notice] = t('phrases.result_search') + t('phrases.by') + 'ip.'
    end

    if not params[:computer][:mac].nil?
      search_by('computers', 'Computer', params[:computer][:mac], 'mac', 10)
      flash[:notice] = t('phrases.result_search') + t('phrases.by') + 'mac.'
    end
  end

  def stats
    @graph = open_flash_chart_object(600,300,"/computers/graph_statistics/show")
    @availables_computers = availables_computers
    @unavailables_computers = unavailables_computers

    render :action => "stats", :layout => "primary-content"

  end

  def graph_statistics
    pie_values
    title = Title.new(t('computers.stats_paragraph'))

    pie = Pie.new
    pie.start_angle = 35
    pie.animate = true
    pie.tooltip = '#val# de #total#<br>#percent# del 100%'
    pie.colours = ["#5858FA", "#FF0080"]
    pie.values  = @pie_values

    chart = OpenFlashChart.new
    chart.title = title
    chart.add_element(pie)
    chart.bg_colour="#FFFFFF"
    chart.x_axis = nil

    render :text => chart.to_s
  end

  def xls_computers
    xls_report('/public/xls/' +
               t('places.computer') + '.xls',
               'computers',
               'Computer',
               'computers',
               "[t('computers.name'),'mac','ip',t('computers.available'),
                 'montherboard', t('computers.harddisk'), t('computers.memory'),
                 'cds', 'dvds', t('computers.inventory_register')]",
               params[:places].nil? ? 'find' : params[:places],
               params[:places].nil? ? '(:all)' : '(' + params[:id] + ')'
               )
  end

  def pdf
    single_pdf_report(Computer.find(params[:id]),
               "A4",
               t('common_actions.report_of') + t('menu.computers'),
               12,
               'computer'
               )
  end

  private
  def availables_computers
    @computers = Computer.available.paginate(
                                             :page => params[:page],
                                             :per_page => PER_PAGE,
                                             :order => 'created_at DESC',
                                             :include => INCLUDE_COMPUTER)
  end


  def unavailables_computers
    @computers = Computer.unavailable.paginate(
                                               :page => params[:page],
                                               :per_page => PER_PAGE,
                                               :order => 'created_at DESC',
                                               :include => INCLUDE_COMPUTER)
  end

  def all_computers
    @computers = Computer.paginate(
                                   :page => params[:page],
                                   :per_page => PER_PAGE,
                                   :order => 'created_at DESC',
                                   :include => INCLUDE_COMPUTER)
  end

  def pie_values
    @pie_values = []
    Computer.available unless @pie_values <<
      PieValue.new(Computer.available.count,t('stats.available').pluralize \
                                                         + '('+ Computer.available.count.to_s + ')')


    Computer.unavailable unless @pie_values <<
      PieValue.new(Computer.unavailable.count,t('stats.unavailable').pluralize \
                                                         + '('+ Computer.unavailable.count.to_s + ')')
  end

end
