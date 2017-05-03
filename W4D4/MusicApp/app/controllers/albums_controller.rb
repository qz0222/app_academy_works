class AlbumsController < ApplicationController
  before_action :bounce
  
  def new
    @album = Album.new
    render :new
  end

  def create
    album = Album.new(album_params)
    if album.save!
      redirect_to bands_url
    else
      render text: 'Invalid Input'
    end
  end

  def show
    @album = Album.find_by(id:params[:id])
    render :show
  end

  def edit
    @album = Album.find_by(id:params[:id])
    render :edit
  end

  def update
    album = Album.find_by(id:params[:id])
    album.update(album_params)
    redirect_to band_url(album.band)
  end

  private
  def album_params
    params.require(:album).permit(:name, :band_id, :status)
  end


end
