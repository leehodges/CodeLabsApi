class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :password_digest
      t.boolean :invitation_accepted, default: false
      t.string :invitation_token
      t.datetime :invitation_expiration

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
