class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    warden.authenticate(scope: :user) || AnonymousUser.new
  end

  def user_signed_in?
    current_user.persisted?
  end
end
