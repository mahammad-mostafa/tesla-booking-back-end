class Api::V1::CarsController < ApplicationController
  before_action :set_car, only: %i[show destroy]

  # POST /api/v1/cars
  def create
    @car = current_user.cars.new(car_params)

    if @car.save
      render json: @car, status: :created
    else
      render json: @car.errors, status: :unprocessable_entity
    end
  end

  # GET /api/v1/cars
  def index
    @cars = Car.all
    render json: @cars, include: [:performance_details]
  end

  # GET /api/v1/cars/1
  def show
    render json: @car, include: [:performance_details]
  end

  # DELETE /api/v1/cars/1
  def destroy
    @car.destroy
    head :no_content
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(
      :model_name,
      :image,
      :description,
      :rental_price,
      performance_details_attributes: [:detail]
    )
  end
end
