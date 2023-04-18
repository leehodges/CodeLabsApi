require 'swagger_helper'
require 'faker'
require 'factory_bot'

RSpec.describe 'api/v1/medications', type: :request do
  user = FactoryBot.create(:user)
  token = FactoryBot.create(:token, user_id: user.id)
  medication = FactoryBot.create(:medication)

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
            user_id: user.id
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
    end
  end

  path '/api/v1/medications/meds' do

    get('meds medication') do
      response(200, 'successful') do

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
  end

  path '/api/v1/medications/delete' do

    delete('delete medication') do
      response(200, 'successful') do

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
  end

  path '/api/v1/medications/edit' do

    patch('edit medication') do
      response(200, 'successful') do

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
  end
end
