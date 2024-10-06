class BattlesController < ApplicationController
  def new_cars
    car1 = Car.order("RANDOM()").first
    car2 = Car.order("RANDOM()").where.not(id: car1.id).first
    render json: {
      car1: {
        id: car1.id,
        brand: car1.brand,
        model: car1.model,
        year: car1.year,
        fuel: car1.fuel,
        image_url: car1.image_url,
        votes_count: car1.votes_count
      },
      car2: {
        id: car2.id,
        brand: car2.brand,
        model: car2.model,
        year: car2.year,
        fuel: car2.fuel,
        image_url: car2.image_url,
        votes_count: car2.votes_count
      }
    }
  end
  def index
    @car1, @car2 = Car.order("RANDOM()").limit(2)
    @top_cars = Car.where("votes_count > ?", 0).order(votes_count: :desc).limit(3)
  end

  def create
    car = Car.find(params[:car_id])
    car.increment!(:votes_count)
    render json: { success: true }
  end
  def vote
    @car = Car.find(params[:id]) # This is the car that was voted for
    @car.increment!(:votes_count) # Increment the vote count

    @votes_count = @car.votes_count # Get the updated vote count

    # Load new cars for the next round
    @car1 = Car.order("RANDOM()").first
    @car2 = Car.order("RANDOM()").where.not(id: @car1.id).first

    respond_to do |format|
      format.js
      format.json { render json: { success: true, votes_count: @votes_count, car1: @car1, car2: @car2 } }
    end
  end

  def leaderboard
    @top_cars = Car.where("votes_count > ?", 0).order(votes_count: :desc).limit(3)
    render partial: "battles/leaderboard", locals: { top_cars: @top_cars }
  end
end
