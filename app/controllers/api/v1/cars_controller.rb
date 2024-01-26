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
    render json: {
      status: { code: 200, message: 'Success: cars data retrieved successfully',
                data: cars_as_json(@cars) }
    }, status: :ok
  end

  # GET /api/v1/cars/1
  def show
    render json: {
      status: { code: 200, message: 'Success: car data retrieved successfully',
                data: car_as_json(@car) }
    }, status: :ok
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

  def car_as_json(car)
    {
      id: car.id,
      user_id: car.user_id,
      model_name: car.model_name,
      image: car.image,
      description: car.description,
      rental_price: car.rental_price,
      performance_details: car.performance_details.pluck(:detail)
    }
  end

  def cars_as_json(cars)
    cars.map { |car| car_as_json(car) }
  end
end
