class CarsController < ApplicationController
  def index
    @cars = Car.all

    # Filtering based on parameters
    if params[:brand].present?
      @cars = @cars.where(brand: params[:brand])
    end

    if params[:fuel].present?
      @cars = @cars.where(fuel: params[:fuel])
    end

    if params[:year].present?
      @cars = @cars.where(year: params[:year])
    end
  end

  def show
    @car = Car.find(params[:id])
    @reviews = @car.reviews
    @review = Review.new
    @favourites = Favourite.where(car: @car)
  end

  def pick
    @car = Car.order("RANDOM()").first
    @favourites = Favourite.where(car: @car)
  end
end
