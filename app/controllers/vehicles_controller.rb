class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.page(params[:page]).per(2)
  end
end
