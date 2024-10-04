class FavouritesController < ApplicationController
  before_action :find_car, only: [ :create, :destroy ]

  def create
    Rails.logger.debug("Parameters: #{params.inspect}")

    @favourite = Favourite.new(car: @car)

    if @favourite.save
      respond_to do |format|
        format.js # Keep this if you want to show alerts on the index page via AJAX
        format.html { redirect_to @car, notice: "Favourite was successfully added." }
      end
    else
      respond_to do |format|
        format.html { redirect_to @car, alert: "Could not add to favourites." }
        format.js { render js: "alert('Error: Could not add to favourites');" }
      end
    end
  end


  def destroy
    Rails.logger.debug("Parameters: #{params.inspect}")

    @favourite = Favourite.find(params[:id])
    @car = @favourite.car
    @favourite.destroy

    respond_to do |format|
      format.html { redirect_to @car, notice: "Favourite was successfully removed." }
      format.js
    end
  end


  def index
    @favourites = Favourite.all
  end

  private

  def find_car
    @car = Car.find(params[:car_id])
  end
end
