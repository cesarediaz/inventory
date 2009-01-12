class WorkstationsController < ApplicationController
  before_filter :login_required

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

  def stats_computers
    if not params[:place_id].nil?
      @are_not_part_a_workstation = Computer.list_for_place_are_not_part_a_workstation(params[:place_id]).count
      @are_part_workstation = Computer.list_for_place_as_part_a_workstation(params[:place_id]).count
      @all_computers = @are_not_part_a_workstation + @are_part_workstation

      if @all_computers > 0
        @p_c_nw = (@are_not_part_a_workstation * 100) / @all_computers
        @p_c_w = (@are_part_workstation * 100) / @all_computers

        @chart = GoogleChart.new
        @chart.type = :pie_3d
        @chart.data = [@are_part_workstation, @are_not_part_a_workstation]
        @chart.colors = '346000'
        @chart.labels = ["Workstations " + @p_c_w.to_s + '%',"Alone " + @p_c_nw.to_s + '%']
      end

    end
  end

  def stats_screens
    if not params[:place_id].nil?
      @are_not_part_a_workstation = Screen.list_for_place_are_not_part_a_workstation(params[:place_id]).count
      @are_part_workstation = Screen.list_for_place_as_part_a_workstation(params[:place_id]).count
      @all_screens = @are_not_part_a_workstation + @are_part_workstation

      if @all_screens > 0
        @p_s_nw = (@are_not_part_a_workstation * 100) / @all_screens
        @p_s_w = (@are_part_workstation * 100) / @all_screens

        @chart_screen = GoogleChart.new
        @chart_screen.type = :pie_3d
        @chart_screen.data = [@are_part_workstation, @are_not_part_a_workstation]
        @chart_screen.colors = '3460FF'
        @chart_screen.labels = ["Workstations " + @p_s_w.to_s + '%',"Alone " + @p_s_nw.to_s + '%']
      end

    end
  end

  def stats_printers
    if not params[:place_id].nil?

      @are_not_part_a_workstation = Printer.list_for_place_are_not_part_a_workstation(params[:place_id]).count
      @are_part_workstation = Printer.list_for_place_as_part_a_workstation(params[:place_id]).count
      @all_printers = @are_not_part_a_workstation + @are_part_workstation


      if @all_printers > 0
        @p_p_nw = (@are_not_part_a_workstation * 100) / @all_printers
        @p_p_w = (@are_part_workstation * 100) / @all_printers

        @chart_printer = GoogleChart.new
        @chart_printer.type = :pie_3d
        @chart_printer.data = [@are_part_workstation, @are_not_part_a_workstation]
        @chart_printer.colors = '346099'
        @chart_printer.labels = ["Workstations " + @p_p_w.to_s + '%',"Alone " + @p_p_nw.to_s + '%']
      end

    end
  end

  private

  def hardware_in_place
    self.stats_computers
    self.stats_screens
    self.stats_printers

    @place_name = Place.find(params[:place_id]).title rescue nil

    @places = Place.all
    @computers = Computer.list_for_place_are_not_part_a_workstation(params[:place_id])
    @screens = Screen.list_for_place_are_not_part_a_workstation(params[:place_id])
    @printers = Printer.list_for_place_are_not_part_a_workstation(params[:place_id])
  end


end
