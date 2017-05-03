class UsersController < ApplicationController


  def index
    render text:'this is index'
  end

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.new(user_params)
    if user.save!
      redirect_to users_url
    else
      render text: 'invalid email or password'
    end
  end

  def show
  
    if current_user && current_user.id == params[:id].to_i
      @user = current_user
      render :show
    else
      redirect_to new_session_url
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end


end
