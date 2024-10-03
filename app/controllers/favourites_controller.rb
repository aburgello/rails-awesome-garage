class FavouritesController < ApplicationController
  def create
    @car = Car.find(params[:car_id])
    Favourite.create(car: @car)
    redirect_to car_path(@car)
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @car = @favourite.car
    @favourite.destroy
    redirect_to car_path(@car)
  end
  def index
      @favourites = Favourite.all
  end
end
