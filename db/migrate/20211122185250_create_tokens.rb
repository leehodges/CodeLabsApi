class CreateTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :value
      t.datetime :expiry
      t.string :ip
      t.datetime :revocation_date

      t.timestamps
    end
  end
end
