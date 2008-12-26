class MemoriesController < ApplicationController
  auto_complete_for :memory, :model
  auto_complete_for :memory, :serialnumber


  # GET /memories
  # GET /memories.xml
  def index
    @memories = Memory.paginate(
                                :page => params[:page],
                                :per_page => PER_PAGE,
                                :order => 'created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @memories }
    end
  end

  # GET /memories/1
  # GET /memories/1.xml
  def show
    @memory = Memory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @memory }
    end
  end

  # GET /memories/new
  # GET /memories/new.xml
  def new
    @memory = Memory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @memory }
    end
  end

  # GET /memories/1/edit
  def edit
    @memory = Memory.find(params[:id])
  end

  # POST /memories
  # POST /memories.xml
  def create
    @memory = Memory.new(params[:memory])

    respond_to do |format|
      if @memory.save
        flash[:notice] = 'Memory was successfully created.'
        format.html { redirect_to(@memory) }
        format.xml  { render :xml => @memory, :status => :created, :location => @memory }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @memory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /memories/1
  # PUT /memories/1.xml
  def update
    @memory = Memory.find(params[:id])

    respond_to do |format|
      if @memory.update_attributes(params[:memory])
        flash[:notice] = 'Memory was successfully updated.'
        format.html { redirect_to(@memory) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @memory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /memories/1
  # DELETE /memories/1.xml
  def destroy
    @memory = Memory.find(params[:id])
    @memory.destroy

    respond_to do |format|
      format.html { redirect_to(memories_url) }
      format.xml  { head :ok }
    end
  end

  def search
    if not params[:memory][:model].nil?
        @memories = Memory.find(:all,
                                   :conditions => [ 'LOWER(model) LIKE ?',
                                                    '%' + params[:memory][:model].downcase + '%' ],
                                   :order => 'model ASC',
                                   :limit => 8)
    end
    if not params[:memory][:serialnumber].nil?
        @memories = Memory.find(:all,
                                   :conditions => [ 'serialnumber LIKE ?',
                                                    '%' + params[:memory][:serialnumber] + '%' ],
                                   :order => 'model ASC',
                                   :limit => 8)
    end
  end


end
