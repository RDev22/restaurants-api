class Api::V1::RestaurantsController < ApplicationController
  acts_as_token_authentication_handler_for User, except: [ :index, :show]
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_restaurant, only: [ :show, :update ]
  def index
    @restaurants = policy_scope(Restaurant)
  end

  def show

  end

  def update
    if @restaurant.update(restaurant_params)
      render :show
    else
      render json: { message: 'Error' }
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address)
  end

end
