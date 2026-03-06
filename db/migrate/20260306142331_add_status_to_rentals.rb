class AddStatusToRentals < ActiveRecord::Migration[8.1]
  def change
    add_column :rentals, :status, :integer, default: 0, null: false
  end
end
