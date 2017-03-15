class RestaurantsController < ApplicationController
  before_action :is_admin?, only: [:edit, :update, :destroy]

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
    if @reviews.blank?
      @avg_rating = 0
    else
      @avg_rating = @reviews.average(:rating).round(2)
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to @restaurant
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to root_path
  end

  def search
    @restaurants = Restaurant.search(params)
  end

  private
    def restaurant_params
      params.require(:restaurant).permit(:name, :description, :address1, :address2, :city, :state, :zipcode, :phone, :email, :category_id)
    end

    def is_admin?
      if !current_user.try(:admin?)
        flash[:notice] = "You are not athorize edit or delete"
        redirect_to root_path
      end
    end

end
