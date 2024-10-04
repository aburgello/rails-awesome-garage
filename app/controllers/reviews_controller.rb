class ReviewsController < ApplicationController
  before_action :set_car

  def create
    @review = @car.reviews.new(review_params)

    if @review.save
      Rails.logger.debug "Review saved successfully."
      respond_to do |format|
        format.js
      end
    else
      Rails.logger.debug "Review failed to save: #{@review.errors.full_messages.join(', ')}"
      respond_to do |format|
        format.js { render js: "alert('Failed to save review: #{@review.errors.full_messages.join(', ')}');" }
      end
    end
  end


  def destroy
    @review = Review.find(params[:id])

    if @review.destroy
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end
  private

  def set_car
    @car = Car.find(params[:car_id])
  end

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
