class Vehicle < ApplicationRecord
  has_one :rental, dependent: :destroy
  has_one :user, through: :rental

  def available?
    rental.nil? || rental.finished?
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "brand", "model", "year", "price", "type" ]
  end
end
