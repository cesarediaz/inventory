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

class MarksController < ApplicationController
  before_filter :login_required
  layout "primary-content"

  auto_complete_for :mark, :name

  # GET /marks
  # GET /marks.xml
  def index
    @marks = Mark.paginate(
                       :page => params[:page],
                       :per_page => PER_PAGE,
                       :select => 'id, name',
                       :order => 'name ASC')

    flash[:notice] = t('phrases.list_of') + ' ' + t('marks.mark')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @marks }
    end
  end

  # GET /marks/1
  # GET /marks/1.xml
  def show
    @mark = Mark.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mark }
    end
  end

  # GET /marks/new
  # GET /marks/new.xml
  def new
    @mark = Mark.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mark }
    end
  end

  # GET /marks/1/edit
  def edit
    @mark = Mark.find(params[:id])
  end

  # POST /marks
  # POST /marks.xml
  def create
    @mark = Mark.new(params[:mark])

    respond_to do |format|
      if @mark.save
        flash[:notice] = 'Mark was successfully created.'
        format.html { redirect_to(@mark) }
        format.xml  { render :xml => @mark, :status => :created, :location => @mark }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /marks/1
  # PUT /marks/1.xml
  def update
    @mark = Mark.find(params[:id])

    respond_to do |format|
      if @mark.update_attributes(params[:mark])
        flash[:notice] = 'Mark was successfully updated.'
        format.html { redirect_to(@mark) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mark.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /marks/1
  # DELETE /marks/1.xml
  def destroy
    @mark = Mark.find(params[:id])
    @mark.destroy

    respond_to do |format|
      format.html { redirect_to(marks_url) }
      format.xml  { head :ok }
    end
  end

  def search
    if not params[:mark][:name].nil?
      search_by('marks', 'Mark', params[:mark][:name], 'name', 10)
    end

    flash[:notice] = t('phrases.result_search')
  end
end
