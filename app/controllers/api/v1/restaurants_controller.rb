class Api::V1::RestaurantsController < ApplicationController
    acts_as_token_authentication_handler_for User, except: [ :index, :show ]
    before_action :set_restaurant, only: [ :show, :update ]
  
    def update
      if @restaurant.update(restaurant_params)
        render :show
      else
        render_error
      end
    end
  
    private
  
    def restaurant_params
      params.require(:restaurant).permit(:name, :address)
    end
  
    def render_error
      render json: { errors: @restaurant.errors.full_messages },
        status: :unprocessable_entity
    end
end
