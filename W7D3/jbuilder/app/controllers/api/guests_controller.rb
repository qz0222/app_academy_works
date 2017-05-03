class Api::GuestsController < ApplicationController
  def index
    @guests = Guest.all.where('age BETWEEN 40 AND 50')
    render :index
  end

  def show
    @guest = Guest.find(params[:id])
    render :show
  end
end
