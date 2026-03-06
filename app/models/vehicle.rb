class Vehicle < ApplicationRecord
  has_many :rentals, dependent: :destroy
  has_many :users, through: :rentals

  def active_rental
    rentals.active.order(created_at: :desc).first
  end

  def available?
    active_rental.nil?
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "brand", "model", "year", "price", "type" ]
  end
end
