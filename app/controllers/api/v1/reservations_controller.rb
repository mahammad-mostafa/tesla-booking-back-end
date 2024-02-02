class Api::V1::ReservationsController < ApplicationController
  include JwtHelper
  before_action :set_car, only: [:create]

  def show
    if current_user
      @reservation = current_user.reservations.find_by(id: params[:id])

      if @reservation
        render json: {
          status: { code: 200, message: 'Success: Reservation data retrieved successfully' },
          data: reservation_as_json(@reservation)
        }, status: :ok
      else
        render json: {
          status: { code: 404, message: 'Error: Reservation not found' }, data: {}
        }, status: :not_found
      end
    else
      render json: {
               status: { code: 400, message: 'Error: Invalid token' },
               data: {}
             },
             status: :ok
    end
  end

  def index
    if current_user
      @reservations = current_user.reservations

      if @reservations.empty?
        render json: {
          status: { code: 200, message: 'Success: No reservations found' }, data: {}
        }, status: :ok
      else
        render json: {
          status: { code: 200, message: 'Success: Reservations data retrieved successfully' },
          data: reservations_as_json(@reservations)
        }, status: :ok
      end
    else
      render json: {
               status: { code: 400, message: 'Error: Invalid token' },
               data: {}
             },
             status: :ok
    end
  end

  def create
    reservation_params = params.require(:reservation).permit(:car_id, :location, :date)
    if current_user
      # Use the current_user method to retrieve the user based on the JWT token
      user = current_user

      # Create the reservation
      @reservation = Reservation.new(
        reservation_params.merge(user_id: user.id)
      )

      if @reservation.save
        render json: {
          status: { code: 200, message: 'Success: reservation created successfully' },
          data: reservation_as_json(@reservation)
        }, status: :created
      else
        render json: {
          status: { code: 422, message: 'Error: unable to create reservation' },
          errors: @reservation.errors.full_messages
        }, status: :unprocessable_entity
      end
    else
      render json: {
        status: { code: 400, message: 'Error: Invalid token' }, data: {}
      }, status: :unprocessable_entity
    end
  end

  private

  def set_car
    @car = Car.find_by(id: params[:reservation][:car_id])

    return if @car

    render json: {
      status: { code: 404, message: 'Error: Car not found' }
    }, status: :not_found
  end

  def reservation_params
    params.permit(:date, :location)
  end

  def reservation_as_json(reservation)
    {
      id: reservation.id,
      userId: reservation.user_id,
      carId: reservation.car_id,
      image: reservation.car.image,
      carModelName: reservation.car.car_model_name,
      rentalPrice: reservation.car.rental_price,
      date: reservation.date,
      location: reservation.location
    }
  end

  def reservations_as_json(reservations)
    reservations.map { |reservation| reservation_as_json(reservation) }
  end
end
