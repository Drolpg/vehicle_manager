class CreateRentals < ActiveRecord::Migration[8.1]
  def change
    create_table :rentals do |t|
      t.references :user, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.decimal :total_price

      t.timestamps
    end
  end
end
