class CreateTimeOfDay < ActiveRecord::Migration[7.0]
  def change
    create_table :time_of_days do |t|
      t.boolean :morning
      t.boolean :midday
      t.boolean :evening
      t.boolean :night
      
      t.timestamps
    end
  end
end
