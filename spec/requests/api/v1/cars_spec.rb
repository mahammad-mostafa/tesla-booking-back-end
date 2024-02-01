require 'swagger_helper'

RSpec.describe 'api/v1/cars', type: :request do
  let(:access_token) { FactoryBot.create(:api_key).access_token }
  let(:Authorization) { "Bearer #{access_token}" }

  path '/api/v1/cars' do
    get('list cars') do
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

    post('create car') do
      # Describe the request parameters
      security [Bearer: {}]
      consumes 'application/json'
      parameter name: :car, in: :body, schema: {
        type: :object,
        properties: {
          car_model_name: { type: :string },
          image: { type: :string },
          description: { type: :string },
          rental_price: { type: :number },
          performance_details_attributes: {
            type: :array,
            items: {
              type: :object,
              properties: {
                detail: { type: :string }
              },
              required: [:detail]
            }
          }
        },
        required: [:car_model_name, :image, :description, :rental_price, :performance_details_attributes]
      }

      # Describe the request headers

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
  path '/api/v1/cars/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show car') do
      response(200, 'successful') do
        let(:id) { '123' }

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

    delete('delete car') do
      parameter name: 'id', in: :path, type: :string, description: 'id'
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
