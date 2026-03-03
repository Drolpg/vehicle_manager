class AddTypeToVehicles < ActiveRecord::Migration[8.1]
  def change
    add_column :vehicles, :type, :string
    add_column :vehicles, :color, :string
  end
end
