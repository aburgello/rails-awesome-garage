class ReviewsController < ApplicationController
  def create
    @car = Car.find(params[:car_id])
    @review = @car.reviews.build(review_params)

    if @review.save
      redirect_to @car, notice: "Review was successfully created."
    else
      redirect_to @car, alert: "Failed to create review."
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to car_path(@review.car), notice: "Review was successfully deleted."
  end
  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
