module JwtHelper
  extend ActiveSupport::Concern

  included do
    class_eval do
      helper_method :decode_jwt
    end
  end

  def current_user
    @current_user ||= decode_jwt
  end

  private

  def decode_jwt
    jwt_token = request.headers['Authorization'].to_s.split.last
    jwt_payload = JWT.decode(jwt_token, Rails.application.credentials.fetch(:secret_key_base)).first
    User.find(jwt_payload['sub'])
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    nil
  end
end
