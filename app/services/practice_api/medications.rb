# frozen_string_literal: true

module PracticeApi
  module Medications
    def self.create(params)
      user = User.find_by(id: params[:user_id])
      medication = user.medications.create(
        name: params[:name],
        dosage: params[:dosage],
        frequency: params[:frequency],
        date: params[:date],
        day: params[:day],
        benefits: params[:benefits],
        side_effects: params[:side_effects],
        start_date: params[:start_date],
        stop_date: params[:stop_date],
        reason_stopped: params[:reason_stopped],
        is_current: params[:is_current],
        morning: params[:morning],
        midday: params[:midday],
        evening: params[:evening],
        night: params[:night], 
      )
      return ServiceContract.error('Error creating medication.') unless medication.save

      ServiceContract.success(medication)
    end

    def self.destroy(params)
      user = User.find(params[:user_id])
      puts user
      medication = user.medications.find(params[:med_id])
      if medication
        return ServiceContract.error('Error deleting medication') unless medication.destroy
        ServiceContract.success(payload: "Medication successfully deleted")
      else
        return ServiceContract.error("Medication doesn't exist for current user")
      end
    end

    def self.edit_med(params)
      user = User.find(params[:user_id])
      editedMed = user.medications.find(params[:id])
      if editedMed
        editedMed.update(
          name: params[:name],
          dosage: params[:dosage],
          frequency: params[:frequency],
          date: params[:date],
          day: params[:day],
          benefits: params[:benefits],
          side_effects: params[:side_effects],
          start_date: params[:start_date],
          stop_date: params[:stop_date],
          reason_stopped: params[:reason_stopped],
          is_current: params[:is_current],
          morning: params[:morning],
          midday: params[:midday],
          evening: params[:evening],
          night: params[:night]
        )
        return ServiceContract.error('Error updating medication.') unless editedMed.save
        ServiceContract.success(editedMed)
      else
        return ServiceContract.error("Medication doesn't exist on current user")
      end
    end

    def self.return_meds(user_id)
      user = User.find_by(id: user_id)
      user_meds = user.medications.all

      return ServiceContract.error("Error retrieving medications") unless user_meds
      ServiceContract.success(user_meds)
    end
  end
end
