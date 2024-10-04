class FavouritesController < ApplicationController
  def create
    @car = Car.find(params[:car_id])
    Favourite.create(car: @car)
    Rails.logger.debug "FavouritesController#create called for car #{@car.id}"

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @car = @favourite.car
    @favourite.destroy

    respond_to do |format|
      format.js   # This will look for destroy.js.erb
    end
  end

  def index
    @favourites = Favourite.all
  end
end
