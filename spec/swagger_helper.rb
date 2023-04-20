# frozen_string_literal: true

require 'rails_helper'
require 'faker'
require 'factory_bot'

user = FactoryBot.create(:user)
token = FactoryBot.create(:token, user_id: user.id)

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    "v1/swagger.yaml" => {
      openapi: "3.0.1",
      info: {
        title: "Base API V1",
        version: "v1"
      },
      paths: {},
      consumes: ["application/json"],
      produces: ["application/json"],
      components: {
        securitySchemes: {
          bearer_auth: {
            type: :http,
            scheme: :bearer,
            bearer_format: :string,
          }
        },
        schemas: {
          ########### USERS_SPEC SCHEMAS ###########
          create_user: {
            type: :object,
            properties: {
              first_name: { type: :string, nullable: false },
              last_name: { type: :string, nullable: false },
              email: { type: :string, nullable: false },
              password: { type: :string, nullable: false },
              password_confirmation: { type: :string, nullable: false }
            },
            required: %w[first_name last_name email password password_confirmation]
          },
          login_user_payload: {
            type: :object, properties: {
              success: { type: :boolean, example: true },
              payload: { type: :object, properties: {
                user: { type: :object, properties: {
                  "id": { type: :integer, example: user.id },
                  "email": { type: :string, example: user.email },
                  "first_name": { type: :string, example: user.first_name },
                  "last_name": { type: :string, example: user.last_name },
                  "name": { type: :string, example: user.name },
                  "token": { type: :object, properties: {
                    "id": { type: :integer, example: token.id },
                    "created_at": { type: :string, example: token.created_at },
                    "expiry": { type: :string, example: token.expiry },
                    "ip": { type: :any, example: token.ip || nil },
                    "revocation_date": { type: :any, example: token.revocation_date || nil },
                    "updated_at": { type: :string, example: token.updated_at },
                    "user_id": { type: :integer, example: token.user_id },
                    "value": { type: :string, example: token.value }
                  } } } } } },
              token: { type: :object, properties: {
                "id": { type: :integer, example: token.id },
                "created_at": { type: :string, example: token.created_at },
                "expiry": { type: :string, example: token.expiry },
                "ip": { type: :any, example: token.ip || nil },
                "revocation_date": { type: :any, example: token.revocation_date || nil },
                "updated_at": { type: :string, example: token.updated_at },
                "user_id": { type: :integer, example: token.user_id },
                "value": { type: :string, example: token.value }
              } },
              status: { type: :integer, example: 200 }
            }
          },
          unauthenticated_user: {
            type: :object, properties: {
              success: { type: :boolean, example: false },
              errors: { type: :string, example: 'User not authenticated' },
              status: { type: :integer, example: 401 }
            }
          },
          logout_user: {
            type: :object, properties: {
              success: { type: :boolean, example: true },
              payload: { type: :string, example: "You have been logged out" }
            }
          },
          login_user: { type: :object, properties: {
            email: { type: :string, required: true, description: 'email required' },
            password: { type: :string, required: true, description: 'password required' }
          },
                        required: %w[email password]
          },
          bad_credentials: { type: :object, properties: {
            error: { type: :string, example: 'Bad Credentials' },
            status: { type: :integer, example: 401 }
          }
          },
          me: {
            type: :object, properties: {
              success: { type: :boolean, example: true },
              payload: {
                type: :object, properties: {
                  id: { type: :integer, example: user.id },
                  email: { type: :string, example: user.email },
                  first_name: { type: :string, example: user.first_name },
                  last_name: { type: :string, example: user.last_name },
                  name: { type: :string, example: user.name }
                }
              }
            }
          },
          create_user_payload:
            { type: :object, properties:
              {
                success: { type: :boolean, example: true },
                payload: {
                  type: :object, properties:
                    {
                      id: { type: :integer, example: user.id },
                      email: { type: :string, example: user.email },
                      first_name: { type: :string, example: user.first_name },
                      last_name: { type: :string, example: user.last_name },
                      name: { type: :string, example: user.name }
                    }
                }
              }
            },
          error_saving_user: {
            type: :object, properties: {
              success: { type: :boolean, example: false },
              "errors": { type: :string, example: "There was a problem creating a new user" },
              "status": { type: :integer, example: 400 }
            }
          },

          ############ END_USER_SPEC SCHEMAS ############
          ################################################
          ########### MEDICATIONS_SPEC SCHEMAS ###########
          new_medication: {
            type: :object, properties: {
              name: {type: :string, nullable: false },
              dosage: {type: :string, nullable: true },
              frequency: {type: :string, nullable: true },
              date: {type: :string, nullable: true },
              day: {type: :string, nullable: true },
              benefits: {type: :string, nullable: true },
              side_effects: {type: :string, nullable: true },
              start_date: {type: :string, nullable: true },
              stop_date: {type: :string, nullable: true },
              reason_stopped: {type: :string, nullable: true },
              is_current: {type: :boolean, nullable: false },
              morning: {type: :boolean, nullable: true },
              midday: {type: :boolean, nullable: true },
              evening: {type: :boolean, nullable: true },
              night: {type: :boolean, nullable: true },
            }
          },

          new_medication_payload: {
            type: :object, properties: {
              success: {type: :boolean, example: true},
              payload: {
                id: {type: :integer},
                name: {type: :string},
                dosage: {type: :string},
                frequency: {type: :string},
                date: {type: :string},
                day: {type: :string},
                benefits: {type: :string},
                side_effects: {type: :string},
                start_date: {type: :string},
                stop_date: {type: :string},
                reason_stopped: {type: :string},
                is_current: {type: :boolean},
                created_at: {type: :string},
                updated_at: {type: :string},
                morning: {type: :boolean},
                midday: {type: :boolean},
                evening: {type: :boolean},
                night: {type: :boolean},
                user_id: {type: :integer}
              }
            }
          },

          meds_medication: {
            type: :object, properties: {
              user_id: { type: :integer }
            }
          },

          meds_medication_payload: {
            type: :object, properties: {
              success: {type: :boolean, example: true},
              payload: {
                id: {type: :integer},
                name: {type: :string},
                dosage: {type: :string},
                frequency: {type: :string},
                date: {type: :string},
                day: {type: :string},
                benefits: {type: :string},
                side_effects: {type: :string},
                start_date: {type: :string},
                stop_date: {type: :string},
                reason_stopped: {type: :string},
                is_current: {type: :boolean},
                created_at: {type: :string},
                updated_at: {type: :string},
                morning: {type: :boolean},
                midday: {type: :boolean},
                evening: {type: :boolean},
                night: {type: :boolean},
                user_id: {type: :integer}
              }
            }
          },

          delete_medication: {
            type: :object, properties: {
              user_id: {type: :integer},
              med_id: {type: :integer}
          }
        },

          edit_medication: {
            type: :object, properties: {
              name: {type: :string, nullable: false },
              dosage: {type: :string, nullable: true },
              frequency: {type: :string, nullable: true },
              date: {type: :string, nullable: true },
              day: {type: :string, nullable: true },
              benefits: {type: :string, nullable: true },
              side_effects: {type: :string, nullable: true },
              start_date: {type: :string, nullable: true },
              stop_date: {type: :string, nullable: true },
              reason_stopped: {type: :string, nullable: true },
              is_current: {type: :boolean, nullable: false },
              morning: {type: :boolean, nullable: true },
              midday: {type: :boolean, nullable: true },
              evening: {type: :boolean, nullable: true },
              night: {type: :boolean, nullable: true },
              }
            }
          }
          ########### END MEDICATIONS_SPEC SCHEMAS ###########
        }
      },
      servers: [
        {
          url: "http://{localHost}",
          variables: {
            localHost: {
              default: "localhost:3000"
            }
          }
        },
        {
          url: "https://{staging}",
          variables: {
            staging: {
              default: "set-staging-url-in-swagger_helper.rb"
            }
          }
        },
        {
          url: "https://{production}",
          variables: {
            production: {
              default: "set-production-url-in-swagger_helper.rb"
            }
          }
        }
      ]
    }
  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :json
end
