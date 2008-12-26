class DvdsController < ApplicationController
  # GET /dvds
  # GET /dvds.xml
  def index
    @dvds = Dvd..paginate(
                          :page => params[:page],
                          :per_page => PER_PAGE,
                          :order => 'created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @dvds }
    end
  end

  # GET /dvds/1
  # GET /dvds/1.xml
  def show
    @dvd = Dvd.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dvd }
    end
  end

  # GET /dvds/new
  # GET /dvds/new.xml
  def new
    @dvd = Dvd.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @dvd }
    end
  end

  # GET /dvds/1/edit
  def edit
    @dvd = Dvd.find(params[:id])
  end

  # POST /dvds
  # POST /dvds.xml
  def create
    @dvd = Dvd.new(params[:dvd])

    respond_to do |format|
      if @dvd.save
        flash[:notice] = 'Dvd was successfully created.'
        format.html { redirect_to(@dvd) }
        format.xml  { render :xml => @dvd, :status => :created, :location => @dvd }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dvd.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /dvds/1
  # PUT /dvds/1.xml
  def update
    @dvd = Dvd.find(params[:id])

    respond_to do |format|
      if @dvd.update_attributes(params[:dvd])
        flash[:notice] = 'Dvd was successfully updated.'
        format.html { redirect_to(@dvd) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dvd.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /dvds/1
  # DELETE /dvds/1.xml
  def destroy
    @dvd = Dvd.find(params[:id])
    @dvd.destroy

    respond_to do |format|
      format.html { redirect_to(dvds_url) }
      format.xml  { head :ok }
    end
  end
end
