class MarksController < ApplicationController
  # GET /marks
  # GET /marks.xml
  def index
    @marks = Mark.find(:all)

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
end
