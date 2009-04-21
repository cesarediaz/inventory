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

class CompaniesController < ApplicationController
  include Countries

  auto_complete_for :company, :name
  auto_complete_for :company, :email

  # GET /companies
  # GET /companies.xml
  def index
    flash[:notice] = t('phrases.list_of') + t('menu.companies').downcase
    @companies = Company.paginate(
                                  :page => params[:page],
                                  :per_page => PER_PAGE,
                                  :order => 'created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.xml
  def show
    @company = Company.find(params[:id])

    countries
    place_coordinates = GoogleGeocoder.geocode(@company.street + ',' + @company.city \
                                               + ',' + @company.country + ' ' + @company.number)
    @map = GMap.new("map")
    @map.center_zoom_init([place_coordinates.lat, place_coordinates.lng], 15)
    place_icon = GMarker.new([place_coordinates.lat,place_coordinates.lng])
    @map.overlay_init(place_icon)

    respond_to do |format|
      format.html { render :layout => "primary-content" }
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.xml
  def new
    @company = Company.new
    countries
    respond_to do |format|
      format.html { render :layout => "primary-content" }
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/1/edit
  def edit
    countries
    @company = Company.find(params[:id])
    render  :layout => "primary-content"
  end

  # POST /companies
  # POST /companies.xml
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        flash[:notice] = 'Company was successfully created.'
        format.html { redirect_to(@company) }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "new", :layout => "primary-content"}
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.xml
  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        flash[:notice] = 'Company was successfully updated.'
        format.html { redirect_to(@company) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit", :layout => "primary-content" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.xml
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(companies_url) }
      format.xml  { head :ok }
    end
  end

  def search
    if not params[:company][:name].nil?
      search_by('companies', 'Company', params[:company][:name], 'name', 10)
    end

    if not params[:company][:email].nil?
      search_by('companies', 'Company', params[:company][:email], 'email', 10)
    end
  end
end
