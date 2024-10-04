class FavouritesController < ApplicationController
  before_action :find_car, only: [ :create, :destroy ]

  def create
    @favourite = Favourite.new(car: @car)

    if @favourite.save
      respond_to do |format|
        format.html { redirect_to @car, notice: "Favourite was successfully added." }
        format.js # This will render create.js.erb
      end
    else
      respond_to do |format|
        format.html { redirect_to @car, alert: "Could not add to favourites." }
        format.js { render js: "alert('Error: Could not add to favourites');" }
      end
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

private

def find_car
  @car = Car.find(params[:car_id])
end
