class CarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_car, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  def index
    @q = Car.ransack(params[:q])
    @cars = @q.result.page(params[:page]).per(2)
  end

  def show
  end

  def new
    @car = Car.new
  end

  def edit
  end

  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: "O carro foi criado com sucesso." }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: "O carro foi atualizado com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @car.destroy!

    respond_to do |format|
      format.html { redirect_to cars_path, notice: "Carro foi deletado com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:brand, :model, :year, :price, :color)
  end
end
