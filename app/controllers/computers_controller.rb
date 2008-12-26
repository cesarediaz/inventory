class ComputersController < ApplicationController

  protect_from_forgery :only => [:create, :update, :destroy]
  auto_complete_for :computer, :name
  auto_complete_for :computer, :ip
  auto_complete_for :computer, :mac


  def index
    @computers = Computer.paginate(
                                   :page => nil,
                                   :conditions => nil,
                                   :order => 'created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @computers }
    end
  end


  def available
    @computers = Computer.available

    respond_to do |format|
      format.html
      format.xml  { render :xml => @computers }
    end
  end

  def unavailable
    @computers = Computer.unavailable

    respond_to do |format|
      format.html
      format.xml  { render :xml => @computers }
    end
  end

  def show
    @computer = Computer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @computer }
    end
  end


  def new
    @computer = Computer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @computer }
    end
  end


  def edit
    @computer = Computer.find(params[:id])
  end


  def create
    @computer = Computer.new(params[:computer])

    respond_to do |format|
      if @computer.save
        flash[:notice] = 'Computer was successfully created.'
        format.html { redirect_to(@computer) }
        format.xml  { render :xml => @computer, :status => :created, :location => @computer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @computer.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @computer = Computer.find(params[:id])

    respond_to do |format|
      if @computer.update_attributes(params[:computer])
        flash[:notice] = 'Computer was successfully updated.'
        format.html { redirect_to(@computer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @computer.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @computer = Computer.find(params[:id])
    @computer.destroy

    respond_to do |format|
      format.html { redirect_to(computers_url) }
      format.xml  { head :ok }
    end
  end


  def search
    if not params[:computer][:name].nil?
        @computers = Computer.find(:all,
                                   :conditions => [ 'LOWER(name) LIKE ?',
                                                    '%' + params[:computer][:name].downcase + '%' ],
                                   :order => 'name ASC',
                                   :limit => 8)
    end
    if not params[:computer][:ip].nil?
        @computers = Computer.find(:all,
                                   :conditions => [ 'ip LIKE ?',
                                                    '%' + params[:computer][:ip] + '%' ],
                                   :order => 'name ASC',
                                   :limit => 8)
    end
    if not params[:computer][:mac].nil?
      @computers = Computer.find(:all,
                                 :conditions => [ 'mac LIKE ?',
                                                  '%' + params[:computer][:mac] + '%' ],
                                 :order => 'name ASC',
                                 :limit => 8)
    end

  end

end
