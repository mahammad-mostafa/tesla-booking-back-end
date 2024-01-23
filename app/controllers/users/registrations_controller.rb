class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def sign_up_params
    params.require(:user).permit(:user_name, :email, :password)
  end

  def respond_with(resource, _options = {})
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Success: Signed up successfully',
                  data: { email: resource.email, user_name: resource.user_name } }
      }, status: :ok
    else  
      render json: {
        status: { code: 422, message: 'Error: '+ resource.errors.full_messages.join(', '), 
        data:{ } }
      }, status: :unprocessable_entity
    end
  end
end
