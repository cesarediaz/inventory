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

class ScreensController < ApplicationController
  include ReportSystem

  before_filter :login_required
  auto_complete_for :screen, :serialnumber

  # GET /screens
  # GET /screens.xml
  def index
    flash[:notice] = t('phrases.list_of') + t('menu.screens').downcase
    @screens = Screen.paginate(
                               :page => params[:page],
                               :per_page => PER_PAGE,
                               :order => 'created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @screens }
    end
  end

  # GET /screens/1
  # GET /screens/1.xml
  def show
    @screen = Screen.find(params[:id])
    flash[:notice] = t('menu.screens')
    respond_to do |format|
      format.html { render :action => "show", :layout => "primary-content"}
      format.xml  { render :xml => @screen }
    end
  end

  # GET /screens/new
  # GET /screens/new.xml
  def new
    @screen = Screen.new

    respond_to do |format|
      format.html { render :action => "new", :layout => "primary-content"}
      format.xml  { render :xml => @screen }
    end
  end

  # GET /screens/1/edit
  def edit
    @screen = Screen.find(params[:id])
    render :action => "edit", :layout => "primary-content"
  end

  # POST /screens
  # POST /screens.xml
  def create
    @screen = Screen.new(params[:screen])

    respond_to do |format|
      if @screen.save
        created_by(self.controller_name, self.action_name, current_user.login, params[:screen])
        flash[:notice] = 'Screen was successfully created.'
        format.html { redirect_to(@screen) }
        format.xml  { render :xml => @screen, :status => :created, :location => @screen }
      else
        format.html { render :action => "new", :layout => "primary-content" }
        format.xml  { render :xml => @screen.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /screens/1
  # PUT /screens/1.xml
  def update
    @screen = Screen.find(params[:id])

    respond_to do |format|
      if @screen.update_attributes(params[:screen])
        update_done_by(self.controller_name, self.action_name, current_user.login, params[:screen])
        flash[:notice] = 'Screen was successfully updated.'
        format.html { redirect_to(@screen) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit", :layout => "primary-content" }
        format.xml  { render :xml => @screen.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /screens/1
  # DELETE /screens/1.xml
  def destroy
    @screen = Screen.find(params[:id])
    deleted_by(self.controller_name, self.action_name, current_user.login, @screen.serialnumber)
    @screen.destroy

    respond_to do |format|
      format.html { redirect_to(screens_url) }
      format.xml  { head :ok }
    end
  end

  def search
    if not params[:screen][:serialnumber].nil?
      search_by('screens', 'Screen', params[:screen][:serialnumber], 'serialnumber', 10)
    end
  end

  def xls_screens
    xls_report('/public/xls/' + t('places.screen') + '.xls',
               'screens',
               'Screen',
               'screens',
               "[t('screens.mark'), t('screens.sn'),
                 'place', t('screens.inventory_register')]",
               params[:places].nil? ? 'find' : params[:places],
               params[:places].nil? ? '(:all)' : '(' + params[:id] + ')'
               )
  end

end
