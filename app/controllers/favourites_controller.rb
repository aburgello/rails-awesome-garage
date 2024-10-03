class FavouritesController < ApplicationController
  def create
    @car = Car.find(params[:car_id])
    Favourite.create(car: @car)

    flash[:notice] = "#{@car.brand} #{@car.model} has been added to your favourites! ❤️"
    redirect_to car_path(@car)
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @car = @favourite.car
    @favourite.destroy
    if request.referer.include?(favourites_path)
      redirect_to favourites_path, notice: "#{@car.brand} #{@car.model} has been removed from your favourites."
    else
      redirect_to car_path(@car), notice: "Car was removed from favourites."
    end
  end

  def index
    @favourites = Favourite.all
  end
end
