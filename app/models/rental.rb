class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle

  validate :vehicle_available
  validate :user_without_rental

  before_save :calculate_price

  def days
    (end_date - start_date).to_i
  end

  def calculate_price
    self.total_price = days * vehicle.price
  end

  private

  def vehicle_available
    if vehicle.rental.present?
      errors.add(:vehicle, "já está alugado")
    end
  end

  def user_without_rental
    if user.rental.present?
      errors.add(:user, "já possui um veículo alugado")
    end
  end
end
