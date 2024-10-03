class ReviewsController < ApplicationController
  before_action :set_car

  def create
    @review = @car.reviews.new(review_params)

    if @review.save
      Rails.logger.debug "Review saved successfully."
      respond_to do |format|
        format.js   # This will look for create.js.erb
        format.html { redirect_to @car, notice: "Review was successfully created." }
      end
    else
      Rails.logger.debug "Review failed to save: #{@review.errors.full_messages.join(', ')}"
      respond_to do |format|
        format.js { render js: "alert('Failed to save review: #{@review.errors.full_messages.join(', ')}');" }
        format.html { redirect_to @car, alert: "Failed to save review: #{@review.errors.full_messages.join(', ')}" }
      end
    end
  end


  def destroy
    @review = Review.find(params[:id]) # Find the review by ID

    if @review.destroy # Attempt to destroy the review
      Rails.logger.debug "Review deleted successfully."
      respond_to do |format|
        format.js   # This will look for destroy.js.erb
      end
    else
      Rails.logger.error "Failed to delete review."
      respond_to do |format|
        format.html { redirect_to cars_path, alert: "Failed to delete the review." } # Handle HTML requests
        format.js   # Optional, but you might want to handle this case in JavaScript too
      end
    end
  end
  private

  def set_car
    @car = Car.find(params[:car_id])  # This line sets @car based on the car_id parameter
  end

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
