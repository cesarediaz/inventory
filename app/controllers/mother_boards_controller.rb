class MotherBoardsController < ApplicationController
  include SearchSystem

  auto_complete_for :mother_board, :title
  auto_complete_for :mother_board, :serialnumber

  # GET /mother_boards
  # GET /mother_boards.xml
  def index
    @mother_boards = MotherBoard.paginate(
                                   :page => params[:page],
                                   :per_page => PER_PAGE,
                                   :order => 'created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mother_boards }
    end
  end

  # GET /mother_boards/1
  # GET /mother_boards/1.xml
  def show
    @mother_board = MotherBoard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mother_board }
    end
  end

  # GET /mother_boards/new
  # GET /mother_boards/new.xml
  def new
    @mother_board = MotherBoard.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mother_board }
    end
  end

  # GET /mother_boards/1/edit
  def edit
    @mother_board = MotherBoard.find(params[:id])
  end

  # POST /mother_boards
  # POST /mother_boards.xml
  def create
    @mother_board = MotherBoard.new(params[:mother_board])

    respond_to do |format|
      if @mother_board.save
        flash[:notice] = 'MotherBoard was successfully created.'
        format.html { redirect_to(@mother_board) }
        format.xml  { render :xml => @mother_board, :status => :created, :location => @mother_board }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mother_board.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mother_boards/1
  # PUT /mother_boards/1.xml
  def update
    @mother_board = MotherBoard.find(params[:id])

    respond_to do |format|
      if @mother_board.update_attributes(params[:mother_board])
        flash[:notice] = 'MotherBoard was successfully updated.'
        format.html { redirect_to(@mother_board) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mother_board.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mother_boards/1
  # DELETE /mother_boards/1.xml
  def destroy
    @mother_board = MotherBoard.find(params[:id])
    @mother_board.destroy

    respond_to do |format|
      format.html { redirect_to(mother_boards_url) }
      format.xml  { head :ok }
    end
  end

  def search
    if not params[:mother_board][:title].nil?
      search_by('mother_boards', 'MotherBoard', params[:mother_board][:title], 'title', 10)
    end

    if not params[:mother_board][:serialnumber].nil?
      search_by('mother_boards', 'MotherBoard', params[:mother_board][:serialnumber], 'serialnumber', 10)
    end
  end


end
