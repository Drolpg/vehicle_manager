class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all.order(created_at: :desc)
  end
end
