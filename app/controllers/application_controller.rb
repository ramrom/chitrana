class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # TODO: Pobably dont need this as this back end should be API only
  #protect_from_forgery with: :exception

  rescue_from StandardError do |ex|
    error = { error: "exception", message: ex.message, class: ex.class.name, backtrace: ex.backtrace }
    Rails.logger.error "Rendering unexpected error: #{error.to_json}"
    render json: { errors: [error] }, status: 500
  end

  rescue_from ActiveRecord::RecordNotFound do
    head :not_found
  end

  rescue_from ActionController::ParameterMissing do |ex|
    message = "Required param: #{ex.param}"
    render json: { errors: { message: message } }, status: :bad_request
  end
end
