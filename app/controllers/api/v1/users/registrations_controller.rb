class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def sign_up_params
    params.permit(:user_name, :email, :password)
  end

  def respond_with(resource, _options = {})
    if resource.persisted?
      token = JWT.encode({ sub: resource.id }, Rails.application.credentials.fetch(:secret_key_base))
      render json: {
        status: { code: 200, message: 'Success: Signed up successfully' },
        data: { email: resource.email, userName: resource.user_name, token: }
      }, status: :ok
    else
      render json: {
        status: { code: 422, message: "Error: #{resource.errors.full_messages.join(', ')}" },
        data: {}
      }, status: :unprocessable_entity
    end
  end
end
