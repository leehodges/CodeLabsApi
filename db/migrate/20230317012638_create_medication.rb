class CreateMedication < ActiveRecord::Migration[7.0]
  def change
    create_table :medications do |t|
      t.string :name
      t.string :dosage
      t.string :frequency
      t.string :date
      t.string :day
      t.string :benefits
      t.string :side_effects
      t.string :start_date
      t.string :stop_date
      t.string :reason_stopped
      t.boolean :is_current

      t.timestamps
    end
  end
end
