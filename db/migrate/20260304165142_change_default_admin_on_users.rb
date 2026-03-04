class ChangeDefaultAdminOnUsers < ActiveRecord::Migration[8.1]
  def change
    User.where(admin: nil).update_all(admin: false)

    change_column_default :users, :admin, false

    change_column_null :users, :admin, false
  end
end
