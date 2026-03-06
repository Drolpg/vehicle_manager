class RentalsController < ApplicationController
  before_action :authenticate_user!

  def new
    @vehicle = Vehicle.find(params[:vehicle_id])
    @rental = Rental.new
  end

  def create
    @vehicle = Vehicle.find(params[:vehicle_id])

    @rental = current_user.build_rental(
      vehicle: @vehicle,
      start_date: params[:rental][:start_date],
      end_date: params[:rental][:end_date]
    )

    if @rental.save
      redirect_to @rental, notice: "Veículo alugado com sucesso!"
    else
      render :new
    end
  end
end
