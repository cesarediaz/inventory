class HarddisksController < ApplicationController

  auto_complete_for :harddisk, :model
  auto_complete_for :harddisk, :serialnumber

  # GET /harddisks
  # GET /harddisks.xml
  def index
    @harddisks = Harddisk.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @harddisks }
    end
  end

  # GET /harddisks/1
  # GET /harddisks/1.xml
  def show
    @harddisk = Harddisk.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @harddisk }
    end
  end

  # GET /harddisks/new
  # GET /harddisks/new.xml
  def new
    @harddisk = Harddisk.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @harddisk }
    end
  end

  # GET /harddisks/1/edit
  def edit
    @harddisk = Harddisk.find(params[:id])
  end

  # POST /harddisks
  # POST /harddisks.xml
  def create
    @harddisk = Harddisk.new(params[:harddisk])

    respond_to do |format|
      if @harddisk.save
        flash[:notice] = 'Harddisk was successfully created.'
        format.html { redirect_to(@harddisk) }
        format.xml  { render :xml => @harddisk, :status => :created, :location => @harddisk }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @harddisk.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /harddisks/1
  # PUT /harddisks/1.xml
  def update
    @harddisk = Harddisk.find(params[:id])

    respond_to do |format|
      if @harddisk.update_attributes(params[:harddisk])
        flash[:notice] = 'Harddisk was successfully updated.'
        format.html { redirect_to(@harddisk) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @harddisk.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /harddisks/1
  # DELETE /harddisks/1.xml
  def destroy
    @harddisk = Harddisk.find(params[:id])
    @harddisk.destroy

    respond_to do |format|
      format.html { redirect_to(harddisks_url) }
      format.xml  { head :ok }
    end
  end

  def search
    if not params[:harddisk][:model].nil?
        @harddisks = Harddisk.find(:all,
                                   :conditions => [ 'LOWER(model) LIKE ?',
                                                    '%' + params[:harddisk][:model].downcase + '%' ],
                                   :order => 'model ASC',
                                   :limit => 8)
    end
    if not params[:harddisk][:serialnumber].nil?
        @harddisks = Harddisk.find(:all,
                                   :conditions => [ 'serialnumber LIKE ?',
                                                    '%' + params[:harddisk][:serialnumber] + '%' ],
                                   :order => 'model ASC',
                                   :limit => 8)
    end
  end
end
