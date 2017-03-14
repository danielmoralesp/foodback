class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new(restaurant: @restaurant)
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = current_user.reviews.build(review_params)
    @review.restaurant = @restaurant
    @review.save
    redirect_to @restaurant
  end

  private
    def review_params
      params.require(:review).permit(:comment, :rating)
    end
end
