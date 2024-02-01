require 'swagger_helper'

RSpec.describe 'api/v1/users/sessions', type: :request do

  path '/api/v1/users/sign_in' do

    post('create user session') do
    consumes 'application/json'
    parameter name: :user, in: :body, schema: {
      type: :object,
      properties: {
        email: { type: :string },
        password: { type: :string }
      },
      required: %i[email password]
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
  path '/api/v1/users/sign_out' do

    delete('delete user session') do
      security [Bearer: {}]
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