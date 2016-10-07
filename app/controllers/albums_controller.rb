class AlbumsController < ApplicationController
  def new
    @band = Band.find(params[:band_id])
    @bands = Band.all
    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.valid?
      @album.save
      flash[:messages] = ["Save successful"]
      redirect_to band_url(@album.band_id)
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to new_band_album_url
    end
  end

  def show
    @album = find_album
    render :show
  end

  def edit
    @album = find_album
    @bands = Band.all
    @band = Band.find(@album.band_id)
    render :edit
  end

  def update
    @album = find_album
    if @album.update(album_params)
      flash[:messages] = ["Update succesful"]
      redirect_to band_url(@album.band_id)
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to band_url(@album.band_id)
    end
  end

  def destroy
    @album = find_album
    @album.destroy

    flash[:messages] = ["Annihilation complete"]
    redirect_to band_url(@album.band_id)
  end

  private

  def album_params
    params.require(:album).permit(:title, :recording, :band_id)
  end

  def find_album
    Album.find(params[:id])
  end

end
