class SessionsController < ApplicationController
  # sign in Information
  def new
    render :new
  end

  # sign in
  def create
    user = User.find_by_credentials(params[:user][:email],params[:user][:password])
    if user
      log_in_user!(user)
      redirect_to user_url(user)
    else
      render text: 'invalid email or password'
    end
  end

  # sign out
  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
      redirect_to users_url
    end
  end


end
