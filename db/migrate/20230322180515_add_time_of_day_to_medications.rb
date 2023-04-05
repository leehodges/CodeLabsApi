class AddTimeOfDayToMedications < ActiveRecord::Migration[7.0]
  def change
    add_column :medications, :morning, :boolean
    add_column :medications, :midday, :boolean
    add_column :medications, :evening, :boolean
    add_column :medications, :night, :boolean
  end
end
