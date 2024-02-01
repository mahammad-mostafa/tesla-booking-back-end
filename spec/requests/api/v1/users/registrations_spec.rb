require 'swagger_helper'

RSpec.describe 'api/v1/users/registrations', type: :request do
  path '/api/v1/users/' do
    post('new user registration') do
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          user_name: { type: :string }
        },
        required: %i[email password user_name]
      }
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
