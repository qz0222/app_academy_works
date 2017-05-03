class BandsController < ApplicationController
  before_action :bounce, except: [:index]

  def index
    @bands = Band.all
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    band = Band.new(name:params[:band][:name])
    if band.save!
      redirect_to bands_url
    else
      render text: 'Invalid Input'
    end
  end

  def show
    @band = Band.find_by(id:params[:id])
    render :show
  end

  def edit
    @band = Band.find_by(id:params[:id])
    render :edit
  end

  def update
    band = Band.find_by(id:params[:id])
    band.update(name:params[:band][:name])
    redirect_to bands_url
  end

  def destroy
    band = Band.find_by(id:params[:id])
    band.destroy
    redirect_to bands_url
  end


end
