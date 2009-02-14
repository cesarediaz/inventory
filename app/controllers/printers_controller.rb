class PrintersController < ApplicationController
  include SearchSystem
  before_filter :login_required
  auto_complete_for :printer, :model
  auto_complete_for :printer, :serialnumber

  # GET /printers
  # GET /printers.xml
  def index
    @printers = Printer.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @printers }
    end
  end

  # GET /printers/1
  # GET /printers/1.xml
  def show
    @printer = Printer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @printer }
    end
  end

  # GET /printers/new
  # GET /printers/new.xml
  def new
    @printer = Printer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @printer }
    end
  end

  # GET /printers/1/edit
  def edit
    @printer = Printer.find(params[:id])
  end

  # POST /printers
  # POST /printers.xml
  def create
    @printer = Printer.new(params[:printer])

    respond_to do |format|
      if @printer.save
        flash[:notice] = 'Printer was successfully created.'
        format.html { redirect_to(@printer) }
        format.xml  { render :xml => @printer, :status => :created, :location => @printer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @printer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /printers/1
  # PUT /printers/1.xml
  def update
    @printer = Printer.find(params[:id])

    respond_to do |format|
      if @printer.update_attributes(params[:printer])
        flash[:notice] = 'Printer was successfully updated.'
        format.html { redirect_to(@printer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @printer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /printers/1
  # DELETE /printers/1.xml
  def destroy
    @printer = Printer.find(params[:id])
    @printer.destroy

    respond_to do |format|
      format.html { redirect_to(printers_url) }
      format.xml  { head :ok }
    end
  end

  def search
    if not params[:printer][:model].nil?
      search_by('printers', 'Printer', params[:printer][:model], 'model', 10)
    end

    if not params[:printer][:serialnumber].nil?
      search_by('printers', 'Printer', params[:printer][:serialnumber], 'serialnumber', 10)
    end
  end

end
