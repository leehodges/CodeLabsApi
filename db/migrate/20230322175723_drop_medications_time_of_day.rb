class DropMedicationsTimeOfDay < ActiveRecord::Migration[7.0]
  def change
    drop_table :medication_time_of_days do |t|
      t.belongs_to :medication, null: false, foreign_key: true
      t.belongs_to :time_of_day, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end