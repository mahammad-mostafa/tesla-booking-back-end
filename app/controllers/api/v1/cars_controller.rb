class Api::V1::CarsController < ApplicationController
    # Render JSON to display all cars
    def index
        @cars = Car.all
        render json: @cars
    end
    
    # Render JSON to display one car
    def show
        render json: @car
    end

    # Create a new car
    def create
        @car = Car.new(car_params)
        if @car.save
            render json: @car
        else
            render json: {error: 'Error creating car'}
        end
    end

    Prvate
    car_params = params.require(:car).permit(:model_name, :image, :description, :rental_price, :user_id)
end
