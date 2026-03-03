class VehiclesController < ApplicationController
  def index
    @q = Vehicle.ransack(params[:q])
    @vehicles = @q.result.page(params[:page]).per(2)
  end
end
