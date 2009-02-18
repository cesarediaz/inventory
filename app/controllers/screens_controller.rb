require 'spreadsheet/excel'
include Spreadsheet

class ScreensController < ApplicationController
  include ReportSystem

  before_filter :login_required
  auto_complete_for :screen, :model
  auto_complete_for :screen, :serialnumber

  # GET /screens
  # GET /screens.xml
  def index
    @screens = Screen.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @screens }
    end
  end

  # GET /screens/1
  # GET /screens/1.xml
  def show
    @screen = Screen.find(params[:id])

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
    @screen.destroy

    respond_to do |format|
      format.html { redirect_to(screens_url) }
      format.xml  { head :ok }
    end
  end

  def search
    if not params[:screen][:model].nil?
      search_by('screens', 'Screen', params[:screen][:model], 'model', 10)
    end

    if not params[:screen][:serialnumber].nil?
      search_by('screens', 'Screen', params[:screen][:serialnumber], 'serialnumber', 10)
    end
  end

  def xls_screens
    xls_report(t('places.screen') + '.xls',
               'screens',
               'Screen',
               'screens',
               "['model', 'serial number', 'mark', 'place']",
               params[:places].nil? ? 'find' : params[:places],
               params[:places].nil? ? '(:all)' : '(' + params[:id] + ')'
               )
  end

end
