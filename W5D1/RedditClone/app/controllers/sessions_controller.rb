class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:username],params[:user][:password])
    if user
      log_in(user)
      redirect_to subs_url
    else
      flash[:errors] = ["User not found"]
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
  end

end
