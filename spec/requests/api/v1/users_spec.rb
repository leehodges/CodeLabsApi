require 'swagger_helper'
require 'faker'
require 'factory_bot'
RSpec.describe 'api/v1/users', type: :request do
  before(:each) do
    Rails.cache.clear
  end
  # Setup a user to test with along with a token for that user using our factories
  user = FactoryBot.create(:user)
  token = FactoryBot.create(:token, user_id: user.id)

  path "/api/v1/users/login" do
    post("login user") do
      tags "Users"
      description "Logs in a user"
      consumes 'application/json'
      parameter name: :login_user, in: :body, schema: { '$ref' => '#/components/schemas/login_user' }
      response "200", "success" do
        let(:login_user) { { email: user.email, password: user.password } }
        it 'returns a valid 200 response' do |example|
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

        schema example: {"success": true, payload: UserBlueprint.render_as_hash(user, view: :login ), "status": 200}
        run_test!
      end
      response "401", "Error: Unauthorized" do
        let(:login_user) { { email: "user@email.com" } }
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
        schema '$ref' => '#/components/schemas/unauthenticated_user'
        run_test!
      end
    end
  end

  path '/api/v1/users/logout' do
    delete("logout user") do
      tags "Users"
      description "Logs out a user"
      produces "application/json"
      security [bearer_auth: []]
      response '200', 'logged out user' do
        let(:Authorization) { "Bearer " + token.value }
        it 'returns a valid 200 response' do |example|
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
        schema '$ref' => '#/components/schemas/logout_user'
        run_test!
      end
      response "401", "authentication failed" do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('bogus:bogus')}" }
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

  path '/api/v1/users/me' do
    get("me user") do
      tags "Users"
      description "Display the current user"
      produces "application/json"
      security [bearer_auth: []]

      response "200", "user profile" do
        let(:Authorization) { "Bearer " + token.value }
        it 'returns a valid 200 response' do |example|
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
        schema example: {payload: UserBlueprint.render_as_hash(user), "status": 200}
        run_test!
      end

      response "401", "authentication failed" do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('bogus:bogus')}" }
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

  path '/api/v1/users/create' do
    post("create user") do
      tags "Users"
      description "Create a new user"
      consumes "application/json"
      produces "application/json"
      parameter name: :create_user, in: :body, schema: { '$ref' => '#/components/schemas/create_user' }
      response '201', "user created" do
        let(:create_user) { { first_name: user.first_name, last_name: user.last_name, email: Faker::Internet.email, phone: user.phone, password: user.password } }
        it 'returns a valid 201 response' do |example|
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
        schema example: {"success": true, payload: UserBlueprint.render_as_hash(user, view: :normal), status: 201}
        run_test!
      end

      response "400", "invalid request" do
        let(:create_user) { { first_name: user.first_name } }
        it 'returns a valid 400 response' do |example|
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
        schema '$ref' => '#/components/schemas/error_saving_user'
        run_test!
      end
    end
  end
end
