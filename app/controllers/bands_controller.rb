class BandsController < ApplicationController
  def index
    render :index
  end

  def new
    render :new
  end

  def create
    @band = Band.new(band_params)

    if @band.valid?
      @band.save
      flash[:messages] = ["Save successful"]
      redirect_to bands_url
    else
      flash[:errors] = @band.errors.full_messages
      redirect_to new_band_url
    end
  end

  def show
    @band = find_band
    render :show
  end

  def edit
    @band = find_band
    render :edit
  end

  def update
    @band = find_band
    if @band.update(band_params)
      flash[:messages] = ["Update succesful"]
      redirect_to band_url(find_band)
    else
      flash[:errors] = @band.errors.full_messages
      redirect_to band_url(find_band)
    end
  end

  def destroy
    @band = find_band
    @band.destroy

    flash[:messages] = ["Annihilation complete"]
    redirect_to bands_url
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end

  def find_band
    Band.find(params[:id])
  end
end
