class Api::V1::Users::SessionsController < Devise::SessionsController
  include JwtHelper
  respond_to :json

  def create
    user = User.find_for_database_authentication(email: params[:email])

    if user&.valid_password?(params[:password])
      sign_in(user)
      respond_with(user, token: generate_jwt_token(user))
    else
      render json: {
        status: { code: 401, message: 'Error: Invalid email or password' },
        data: {}
      }, status: :unauthorized
    end
  end

  private

  def generate_jwt_token(user)
    payload = { sub: user.id, email: user.email }
    JWT.encode(payload, Rails.application.credentials.fetch(:secret_key_base))
  end

  def respond_with(resource, options = {})
    token = options[:token]
    render json: {
      status: { code: 200, message: 'Success: User signed in successfully' },
      data: { email: resource.email, userName: resource.user_name, token: }
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      sign_out(current_user)
      render json: {
        status: { code: 200, message: 'Success: Signed out successfully' },
        data: {}
      }, status: :ok
    else
      render json: {
        status: { code: 401,
                  message: 'Error: User has no active session' },
        data: {}
      }, status: :unauthorized
    end
  end
end
