class SessionsController < ApplicationController
  before_action :require_current_user, only: []

  def new

  end

  def create
    @user = User.find_by_credentials(
    params[:user][:username], params[:user][:password]
    )
    if @user.nil?
      flash[:errors] = "Wrong Credentials"
      render :new
    else
      login(@user)
      redirect_to subs_url
    end

  end


  def destroy
    logout
    redirect_to new_session_url
  end


end
