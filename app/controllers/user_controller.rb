class UserController < ApplicationController
  def config
    #render json: User.find(param[:user_id]).get_config
    render json: User.get_config
  end
end
