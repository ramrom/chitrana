Rails.application.routes.draw do
  root  to: 'status#index'

  get '/status'     => 'status#index'
end
