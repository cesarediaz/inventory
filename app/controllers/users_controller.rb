# This file is part of Hardware Inventory.
#
#     Copyright (C) 2009 Cesar Diaz
#
#     Hardware Inventory is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     any later version.
#
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with this program. If not, see <http://www.gnu.org/licenses/>.

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

  def history
    @user_log = params[:user]
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

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(list_users_url) }
      format.xml  { head :ok }
    end
  end

  protected

  def load_user
    @user = User.find(params[:id]) if logged_in?
  end

  def logged_in
    logged_in? ? load_user : redirect_to('/')
  end

  def help
  end

end
