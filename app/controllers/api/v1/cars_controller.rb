class Api::V1::CarsController < ApplicationController
  include JwtHelper
  # POST /api/v1/cars
  def create
    @car = current_user.cars.new(car_params)

    if @car.save
      render json: { status: { code: 200, message: 'Success: Car Created Successfully', data: {} } 
      }, status: :created
    else
      render json: { status: { code: 404, message: 'Error: Can not create car' + @car.errors , data: {} } 
      }, status: :unprocessable_entity
    end
  end

  # GET /api/v1/cars
  def index
    @cars = Car.all
    if @cars.empty?
    render json: { status: { code: 200, message: 'Success: No Car Available', data: {} } 
    }, status: :ok
    else
    render json: {
      status: { code: 200, message: 'Success: cars data retrieved successfully',
                data: cars_as_json(@cars) }
    }, status: :ok
    end
  end

  # GET /api/v1/cars/1
  def show
    @car = Car.find(params[:id])
    render json: {
      status: { code: 200, message: 'Success: car data retrieved successfully',
                data: car_as_json(@car) }
    }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: {
      status: { code: 404, message: 'Error: Car not found',
                data: {} }
    }, status: :not_found
  end

  # GET /api/v1/cars/usercars/
  def user_cars
    if current_user
      user_id = current_user.id
      @user_cars = Car.where(user_id:)
      if @user_cars.empty?
        render json: {
          status: { code: 200, message: 'Success: No Car Available For this User', data: {} }
        }, status: :ok
      else
        render json: {
          status: { code: 200, message: 'Success: Cars for user retrieved successfully', data: cars_as_json(@user_cars) }
        }, status: :ok
      end
    else
      render json: {
        status: { code: 404, message: 'Error: Invalid Token', data: {} }
      }, status: :not_found
    end
  end

  # DELETE /api/v1/cars/1
  def destroy
    @car = Car.find(params[:id])
    if @car.user_id == current_user.id
      @car.destroy
      if @car.destroyed?
        render json: { status: { code: 200, message: 'Success: Car deleted successfully', data: {} } }, status: :ok
      else
        render json: {
          status: { code: 404, message: 'Error: Car Not Deleted', data: {} }
        }, status: :unprocessable_entity
      end
    else
      render json: {
        status: { code: 401, message: 'Error: Invalid Token', data: {} }
      }, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render json: {
      status: { code: 404, message: 'Error: Car Not Found', data: {} }
    }, status: :not_found
  end

  private

  def car_params
    params.require(:car).permit(
      :car_model_name,
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
      car_model_name: car.car_model_name,
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
