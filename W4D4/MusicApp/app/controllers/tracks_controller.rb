class TracksController < ApplicationController
  before_action :bounce
  
  def new
    @track = Track.new
    render :new
  end

  def create
    track = Track.new(track_params)
    if track.save!
      redirect_to band_url(track.album.band)
    else
      render text: 'Invalid Input'
    end
  end

  def show
    @track = Track.find_by(id:params[:id])
    render :show
  end

  def edit
    @track = Track.find_by(id:params[:id])
    render :edit
  end

  def update
    track = Track.find_by(id:params[:id])
    track.update(track_params)
    redirect_to album_url(track.album)
  end

  def destroy
    track = Track.find_by(id:params[:id])
    album = track.album
    track.destroy
    redirect_to album_url(album)
  end

  private
  def track_params
    params.require(:track).permit(:name, :album_id, :status, :description)
  end


end
