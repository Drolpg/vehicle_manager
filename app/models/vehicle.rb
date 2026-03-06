class Vehicle < ApplicationRecord
  has_one :rental
  has_one :user, through: :rental

  def available?
    rental.nil?
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "brand", "model", "year", "price", "type" ]
  end
end
