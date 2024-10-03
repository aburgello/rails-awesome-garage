class ReviewsController < ApplicationController
  def create
    @car = Car.find(params[:car_id])
    @review = @car.reviews.build(review_params)

    if @review.save
      redirect_to car_path(@car)
    else
      render "cars/show"
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
