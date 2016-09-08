class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # TODO: Pobably dont need this as this back end should be API only
  #protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound do
    head :not_found
  end

  rescue_from ActionController::ParameterMissing do |ex|
    message = "Required param: #{ex.param}"
    render json: { errors: { message: message } }, status: :bad_request
  end
end
