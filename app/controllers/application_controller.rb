class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def admin_required
    authenticate_or_request_with_http_basic do |username, password|
      username=="outsideup" && password==Rails.application.secrets.admin_password
    end # if RAILS_ENV == 'production' || params[:admin_http] # I got this here but I don't know if I need it: http://stackoverflow.com/questions/119197/the-rails-way-namespaces
  end
end
