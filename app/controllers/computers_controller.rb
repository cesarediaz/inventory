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

require 'spreadsheet/excel'
include Spreadsheet

class ComputersController < ApplicationController
  include ReportSystem
  include ChartSystem

  before_filter :login_required

  auto_complete_for :computer, :name
  auto_complete_for :computer, :ip
  auto_complete_for :computer, :mac

  def index
    @computers = all_computers

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @computers }
    end
  end


  def available
    @computers = availables_computers

    respond_to do |format|
      format.html { render :action => "available", :layout => "primary-content" }
      format.xml  { render :xml => @computers }
    end
  end

  def unavailable
    @computers = unavailables_computers

    respond_to do |format|
      format.html { render :action => "unavailable", :layout => "primary-content" }
      format.xml  { render :xml => @computers }
    end
  end

  def show
    @computer = Computer.find(params[:id])

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
        flash[:notice] = 'Computer was successfully created.'
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
        flash[:notice] = 'Computer was successfully updated.'
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
    @computer.destroy

    respond_to do |format|
      format.html { redirect_to(computers_url) }
      format.xml  { head :ok }
    end
  end

  def search
    if not params[:computer][:name].nil?
      search_by('computers', 'Computer', params[:computer][:name], 'name', 10)
    end

    if not params[:computer][:ip].nil?
      search_by('computers', 'Computer', params[:computer][:ip], 'ip', 10)
    end

    if not params[:computer][:mac].nil?
      search_by('computers', 'Computer', params[:computer][:mac], 'mac', 10)
    end
  end

  def stats
    @availables_computers = availables_computers
    @unavailables_computers = unavailables_computers
    google_chart([Computer.available.count, Computer.unavailable.count],
                 [t('stats.available'), t('stats.unavailable')],
                 Computer.find(:all).count, 'chart',
                 t('computers.title')
                 )
    render :action => "stats", :layout => "primary-content"

  end


  def xls_computers
    xls_report('/public/xls/' +
               t('places.computer') + '.xls',
               'computers',
               'Computer',
               'computers',
               "[t('computers.name'),'mac','ip',t('computers.workstation?'),
                 'montherboard', t('computers.harddisk'), t('computers.memory'),
                 'cds', 'dvds', t('computers.inventory_register')]",
               params[:places].nil? ? 'find' : params[:places],
               params[:places].nil? ? '(:all)' : '(' + params[:id] + ')'
               )
  end

  private
  def availables_computers
    @computers = Computer.available.paginate(
                                             :page => params[:page],
                                             :per_page => PER_PAGE,
                                             :order => 'created_at DESC')
  end


  def unavailables_computers
    @computers = Computer.unavailable.paginate(
                                               :page => params[:page],
                                               :per_page => PER_PAGE,
                                               :order => 'created_at DESC')
  end

  def all_computers
    @computers = Computer.paginate(
                                   :page => params[:page],
                                   :per_page => PER_PAGE,
                                   :order => 'created_at DESC')
  end

end
