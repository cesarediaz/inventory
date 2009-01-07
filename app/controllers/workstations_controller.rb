class WorkstationsController < ApplicationController
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


  private

  def hardware_in_place
    @place_name = Place.find(params[:place_id]).title rescue nil

    @places = Place.all
    @computers = Computer.list_for_place_are_not_part_a_workstation(params[:place_id])
    @screens = Screen.list_for_place_are_not_part_a_workstation(params[:place_id])
    @printers = Printer.list_for_place_are_not_part_a_workstation(params[:place_id])
  end
end
