class AddUserToMedications < ActiveRecord::Migration[7.0]
  def change
    add_reference :medications, :user, foreign_key: true
  end
end
