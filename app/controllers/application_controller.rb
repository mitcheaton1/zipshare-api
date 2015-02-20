class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate

  private

  # Sets status code to 401 unless a valid authorization header is provided
  def authenticate
    if authorized?
      current_user.update_attributes(last_activity_at: DateTime.now)
    else
      render(json: { errors: "invalid credentials" }, status: 401)
    end
  end

  # Checks if the authorization header matches a user and their access token
  def authorized?
    return false unless request.authorization
    current_user
  end

  # Retrieves the current user
  def current_user
    @current_user ||= Authenticator.new(User.method(:find_by)).authenticate(*decoded_credentials)
  end

  # Breaks authorization header into email and access token
  # @return Array <String>
  def decoded_credentials
    Base64.decode64(request.authorization).split(":")
  end
end
