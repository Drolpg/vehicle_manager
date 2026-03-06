class RentalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vehicle, only: [ :new, :create ]

  def new
    @rental = Rental.new
  end

  def create
    @rental = current_user.rentals.build(rental_params)
    @rental.vehicle = @vehicle

    if @rental.save
      redirect_to @rental, notice: "Veículo alugado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @rental = current_user.rentals.find(params[:id])
  end

  def my_rentals
    @current_rental = Rental.current_for_user(current_user).first
    @rental_history = Rental.history_for_user(current_user)
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id])
  end

  def rental_params
    params.require(:rental).permit(:start_date, :end_date)
  end
end
