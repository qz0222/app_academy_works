class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if user
      redirect_to user_url(user)
    else
      redirect_to new_session_url
    end

  end

  def destroy

  end


end
