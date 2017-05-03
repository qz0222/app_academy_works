class SubsController < ApplicationController
  before_action :require_sign_in

  def index
    @subs = Sub.all
    render :index
  end

  def new
    render :new
  end

  def create
    @sub = current_user.subs.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = current_user.subs.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def destroy
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
