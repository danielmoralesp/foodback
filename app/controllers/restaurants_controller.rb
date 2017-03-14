class RestaurantsController < ApplicationController

  def index
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to @restaurant
    else
      flash[:error] = @restaurant.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @reviews = Review.where(restaurant_id: @restaurant)
  end

  private
    def restaurant_params
      params.require(:restaurant).permit(:name, :description, :address1, :address2, :city, :state, :zipcode, :phone, :email, :category_id)
    end

end
