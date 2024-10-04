class FavouritesController < ApplicationController
  def create
    @car = Car.find(params[:car_id])
    @favourite = Favourite.create(car: @car)

    respond_to do |format|
      format.html { redirect_to @car, notice: "#{@car.brand} #{@car.model} was successfully added to your favourites." }
      format.js
    end
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @car = @favourite.car
    @favourite.destroy

    respond_to do |format|
      format.js   # This will render destroy.js.erb
    end
  end

  def index
    @favourites = Favourite.all
  end
end
