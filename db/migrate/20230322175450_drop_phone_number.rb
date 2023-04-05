class DropPhoneNumber < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :phone
  end
end
