class MotorcyclesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_motorcycle, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  def index
    @q = Motorcycle.ransack(params[:q])
    @motorcycles = @q.result.page(params[:page]).per(2)
  end

  def show
  end

  def new
    @motorcycle = Motorcycle.new
  end

  def edit
  end

  def create
    @motorcycle = Motorcycle.new(motorcycle_params)

    respond_to do |format|
      if @motorcycle.save
        format.html { redirect_to @motorcycle, notice: "Motocicleta foi criada com sucesso." }
        format.json { render :show, status: :created, location: @motorcycle }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @motorcycle.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @motorcycle.update(motorcycle_params)
        format.html { redirect_to @motorcycle, notice: "Motocicleta foi atualizada com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @motorcycle }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @motorcycle.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @motorcycle.destroy!

    respond_to do |format|
      format.html { redirect_to motorcycles_path, notice: "Motocicleta foi deletada com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_motorcycle
      @motorcycle = Motorcycle.find(params[:id])
    end

    def motorcycle_params
      params.require(:motorcycle).permit(:brand, :model, :year, :price, :color)
    end
end
