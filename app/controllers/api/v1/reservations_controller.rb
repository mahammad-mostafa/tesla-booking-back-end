class Api::V1::ReservationsController < ApplicationController
  def index
    @reservations = current_user.reservations
    render json: @reservations
  end

  def create
    @car = Car.find(params[:car_id])
    @reservation = @car.reservations.new(reservation_params)
    @reservation.user = current_user

    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: { errors: @reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:date, :location)
  end
end
