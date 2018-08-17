class AddUserRole < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :string, default: "droid"
  end
end
