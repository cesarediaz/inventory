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
class CdsController < ApplicationController
  before_filter :login_required

  auto_complete_for :cd, :model
  auto_complete_for :cd, :serialnumber

  # GET /cds
  # GET /cds.xml
  def index
    flash[:notice] = t('phrases.list_of') + t('menu.cds').downcase
    @cds = Cd.paginate(
                       :page => params[:page],
                       :per_page => PER_PAGE,
                       :order => 'created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cds }
    end
  end

  # GET /cds/1
  # GET /cds/1.xml
  def show
    @cd = Cd.find(params[:id])
    flash[:notice] = t('menu.cds')
    respond_to do |format|
      format.html { render :action => "show", :layout => "primary-content"}
      format.xml  { render :xml => @cd }
    end
  end

  # GET /cds/new
  # GET /cds/new.xml
  def new
    @cd = Cd.new

    respond_to do |format|
      format.html { render :action => "new", :layout => "primary-content"}
      format.xml  { render :xml => @cd }
    end
  end

  # GET /cds/1/edit
  def edit
    @cd = Cd.find(params[:id])
    render :action => "edit", :layout => "primary-content"
  end

  # POST /cds
  # POST /cds.xml
  def create
    @cd = Cd.new(params[:cd])

    respond_to do |format|
      if @cd.save
        flash[:notice] = 'Cd was successfully created.'
        format.html { redirect_to(@cd) }
        format.xml  { render :xml => @cd, :status => :created, :location => @cd }
      else
        format.html { render :action => "new", :layout => "primary-content" }
        format.xml  { render :xml => @cd.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cds/1
  # PUT /cds/1.xml
  def update
    @cd = Cd.find(params[:id])

    respond_to do |format|
      if @cd.update_attributes(params[:cd])
        flash[:notice] = 'Cd was successfully updated.'
        format.html { redirect_to(@cd) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit", :layout => "primary-content" }
        format.xml  { render :xml => @cd.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cds/1
  # DELETE /cds/1.xml
  def destroy
    @cd = Cd.find(params[:id])
    @cd.destroy

    respond_to do |format|
      format.html { redirect_to(cds_url) }
      format.xml  { head :ok }
    end
  end

  def search
    if not params[:cd][:model].nil?
      search_by('cds', 'Cd', params[:cd][:model], 'model', 10)
    end
    if not params[:cd][:serialnumber].nil?
      search_by('cds', 'Cd', params[:cd][:serialnumber], 'serialnumber', 10)
    end
  end
end
