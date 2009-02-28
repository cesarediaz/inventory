class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  layout "primary-content"

  def list
    @users = User.paginate(
                           :page => params[:page],
                           :per_page => PER_PAGE,
                           :order => 'created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users}
    end
  end

  def new
    @user = User.new
  end

  def create
    #logout_keeping_session! # !! not logout

    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?

      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      #self.current_user = @user # !! now NOT logged in

      redirect_back_or_default('/users/list')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  def edit
    begin
      logged_in
    rescue ActiveRecord::RecordNotFound
      redirect_to ('/')
    end
  end

  def update
    load_user
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to('/users/list') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  protected

  def load_user
    @user = User.find(params[:id]) if logged_in?
  end

  def logged_in
    logged_in? ? load_user : redirect_to('/')
  end

end
