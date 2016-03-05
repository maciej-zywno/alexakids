class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  before_action :authenticate_user!

  rescue_from Exception do |e|
    raise e
  end

  rescue_from Pundit::NotAuthorizedError, with: :render_unathorized_error

  private

  def render_unathorized_error
    redirect_to '/401.html'
  end
end
