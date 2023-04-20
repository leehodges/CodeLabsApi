require 'swagger_helper'
require 'faker'
require 'factory_bot'

RSpec.describe 'api/v1/medications', type: :request do
  user = FactoryBot.create(:user)
  token = FactoryBot.create(:token, user_id: user.id)
  medication = FactoryBot.create(:medication, user_id: user.id)

  path '/api/v1/medications/new' do
    post('new medication') do
        tags "Medications"
        description "Creates a new medication record"
        consumes 'application/json'
        produces 'application/json'
        security [bearer_auth: []]
        parameter name: :new_medication, in: :body, schema: { '$ref' => '#/components/schemas/new_medication'}
        response "200", "success" do
          let(:Authorization) { "Bearer " + token.value }
          let(:new_medication) { {
            name: medication.name, 
            dosage: medication.dosage,
            frequency: medication.frequency,
            date: medication.date,
            day: medication.day,
            benefits: medication.benefits,
            side_effects: medication.side_effects,
            start_date: medication.start_date,
            stop_date: medication.stop_date,
            reason_stopped: medication.reason_stopped,
            is_current: medication.is_current,
            morning: medication.morning,
            midday: medication.midday,
            evening: medication.evening,
            night: medication.night,
            user_id: medication.user_id
          } }
          it 'returns a valid 200 response' do |example|
            assert_response_matches_metadata(example.metadata)
          end
          after do |example|
            example.metadata[:response][:content] = {
              'application/json' => {
                example: JSON.parse(response.body, symbolize_names: true)
              }
            }
          end
        run_test!
      end
      
      response "401", "authentication failed" do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('bogus:bogus')}" }
        let(:new_medication) { {
            name: medication.name, 
            dosage: medication.dosage,
            frequency: medication.frequency,
            date: medication.date,
            day: medication.day,
            benefits: medication.benefits,
            side_effects: medication.side_effects,
            start_date: medication.start_date,
            stop_date: medication.stop_date,
            reason_stopped: medication.reason_stopped,
            is_current: medication.is_current,
            morning: medication.morning,
            midday: medication.midday,
            evening: medication.evening,
            night: medication.night,
            user_id: medication.user_id
          } }
        it 'returns a valid 401 response' do |example|
          assert_response_matches_metadata(example.metadata)
        end
        after do |example|
          content = example.metadata[:response][:content] || {}
          example_spec = {
            "application/json"=>{
              examples: {
                test_example: {
                  value: JSON.parse(response.body, symbolize_names: true)
                }
              }
            }
          }
          example.metadata[:response][:content] = content.deep_merge(example_spec)
        end
        schema '$ref' => '#/components/schemas/bad_credentials'
        run_test!
      end
    end
  end

  # path '/api/v1/medications/meds' do

  #   get('meds medication') do
  #     tags "Medications"
  #     description "Retrieves user's stored medications"
  #     consumes 'application/json'
  #     produces 'application/json'
  #     security [bearer_auth: []]
  #     parameter name: :meds_medication, in: :body, schema: { '$ref' => '#/components/schemas/meds_medication'}
  #     response(200, 'successful') do
  #       let(:Authorization) { "Bearer " + token.value }
  #       let(:meds_medication) { {user_id: user.id} }
  #       after do |example|
  #         example.metadata[:response][:content] = {
  #           'application/json' => {
  #             example: JSON.parse(response.body, symbolize_names: true)
  #           }
  #         }
  #       end
  #       run_test!
  #     end
  #   end
  #   response "401", "authentication failed" do
  #     let(:Authorization) { "Bearer #{::Base64.strict_encode64('bogus:bogus')}" }
  #     let(:meds_medication) { {user_id: user.id} }
  #     after do |example|
  #       content = example.metadata[:response][:content] || {}
  #       example_spec = {
  #         "application/json"=>{
  #           examples: {
  #             test_example: {
  #               value: JSON.parse(response.body, symbolize_names: true)
  #             }
  #           }
  #         }
  #       }
  #       example.metadata[:response][:content] = content.deep_merge(example_spec)
  #     end
  #     schema '$ref' => '#/components/schemas/bad_credentials'
  #     run_test!
  #   end
  # end

  path '/api/v1/medications/delete' do

    delete('delete medication') do      
      tags "Medications"
      description "Retrieves user's stored medications"
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: :delete_medication, in: :body, schema: { '$ref' => '#/components/schemas/delete_medication'}
      response(200, 'successful') do
        let(:Authorization) { "Bearer " + token.value }
        let(:delete_medication) { {user_id: user.id, med_id: medication.id } }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
    # response "401", "authentication failed" do
    #   let(:Authorization) { "Bearer #{::Base64.strict_encode64('bogus:bogus')}" }
    #   let(:delete_medication) { {user_id: user.id, med_id: medication.id} }
    #   after do |example|
    #     content = example.metadata[:response][:content] || {}
    #     example_spec = {
    #       "application/json"=>{
    #         examples: {
    #           test_example: {
    #             value: JSON.parse(response.body, symbolize_names: true)
    #           }
    #         }
    #       }
    #     }
    #     example.metadata[:response][:content] = content.deep_merge(example_spec)
    #   end
    #   schema '$ref' => '#/components/schemas/bad_credentials'
    #   run_test!
    # end
  end

  path '/api/v1/medications/edit' do

    patch('edit medication') do
      tags "Medications"
      description "Edits a stored medication"
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: :edit_medication, in: :body, schema: { '$ref' => '#/components/schemas/edit_medication'}
      response(200, 'successful') do
        let(:Authorization) { "Bearer " + token.value }
        let(:edit_medication) { {
          id: medication.id,
          name: "updated name", 
          dosage: medication.dosage,
          frequency: medication.frequency,
          date: medication.date,
          day: medication.day,
          benefits: medication.benefits,
          side_effects: medication.side_effects,
          start_date: medication.start_date,
          stop_date: medication.stop_date,
          reason_stopped: medication.reason_stopped,
          is_current: medication.is_current,
          morning: medication.morning,
          midday: medication.midday,
          evening: medication.evening,
          night: medication.night,
          user_id: medication.user_id
        } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
    # response "401", "authentication failed" do
    #   let(:Authorization) { "Bearer " + token.value }
    #   let(:edit_medication) { {
    #     id: medication.id,
    #     name: "updated name", 
    #     dosage: medication.dosage,
    #     frequency: medication.frequency,
    #     date: medication.date,
    #     day: medication.day,
    #     benefits: medication.benefits,
    #     side_effects: medication.side_effects,
    #     start_date: medication.start_date,
    #     stop_date: medication.stop_date,
    #     reason_stopped: medication.reason_stopped,
    #     is_current: medication.is_current,
    #     morning: medication.morning,
    #     midday: medication.midday,
    #     evening: medication.evening,
    #     night: medication.night,
    #     user_id: medication.user_id
    #   } }
    #   after do |example|
    #     content = example.metadata[:response][:content] || {}
    #     example_spec = {
    #       "application/json"=>{
    #         examples: {
    #           test_example: {
    #             value: JSON.parse(response.body, symbolize_names: true)
    #           }
    #         }
    #       }
    #     }
    #     example.metadata[:response][:content] = content.deep_merge(example_spec)
    #   end
    #   schema '$ref' => '#/components/schemas/bad_credentials'
    #   run_test!
    # end
  
  end
end
