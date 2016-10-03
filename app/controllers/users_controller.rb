class UserController < ApplicationController
  def config
    #render json: User.find(param[:user_id]).get_config
    render json: User.get_config
  end

  def show
  end

  def create
  end
end
