class ApplicationController < ActionController::API
  include Devise::Controllers::Helpers
  include JwtHelper
end
