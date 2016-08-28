class StatusController < ApplicationController

  def index
    render json: { app: 'chitrana', status: 'OK', version: ENV['RAILS_APP_VERSION'] }
  end
end
