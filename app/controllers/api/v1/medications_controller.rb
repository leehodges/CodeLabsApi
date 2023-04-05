module Api
  module V1
    class MedicationsController < Api::V1::ApplicationController
    before_action :authenticate

      def delete
        result = PracticeApi::Medications.destroy(params)
        render_error(errors: result.errors) and return unless result.success?

        render_success(payload: result.payload)
      end

      def edit
        result = PracticeApi::Medications.edit_med(params)

        render_error(errors: result.errors) and return unless result.success?
        render_success(payload: result.payload)
      end

      def meds
        result = PracticeApi::Medications.return_meds(params[:user_id])
        render_error(errors: result.errors) and return unless result.success?

        render_success(payload: result.payload)
      end

      def new
        result = PracticeApi::Medications.create(params)
        render_error(errors: "Error saving medication", status: 500) and return unless result.success?

        render_success(payload: result, status: 200)
      end
    end
  end
end
