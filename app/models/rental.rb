class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle

  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :valid_dates
  validate :vehicle_available
  validate :user_without_active_rental

  before_validation :calculate_price

  def days
    return 0 if start_date.blank? || end_date.blank?
    return 0 if end_date < start_date

    (end_date - start_date).to_i + 1
  end

  def calculate_price
    return if start_date.blank? || end_date.blank? || vehicle.blank?
    return if end_date < start_date

    self.total_price = days * vehicle.price
  end

  private

  def valid_dates
    return if start_date.blank? || end_date.blank?

    if end_date < start_date
      errors.add(:end_date, "deve ser maior ou igual à data de início")
    end
  end

  def vehicle_available
    return if vehicle.blank?

    rental_exists = Rental.where(vehicle_id: vehicle_id)
                          .where.not(id: id)
                          .exists?

    if rental_exists
      errors.add(:vehicle, "já está alugado")
    end
  end

  def user_without_active_rental
    return if user.blank?

    rental_exists = Rental.where(user_id: user_id)
                          .where.not(id: id)
                          .exists?

    if rental_exists
      errors.add(:user, "já possui um veículo alugado")
    end
  end
end
