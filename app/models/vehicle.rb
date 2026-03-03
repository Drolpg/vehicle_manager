class Vehicle < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    [ "brand", "model", "year", "price", "type" ]
  end
end
