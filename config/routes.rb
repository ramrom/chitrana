Rails.application.routes.draw do
  root  to: 'home#index'

  get '/d3'         => 'home#d3'
  get '/bootstrap'  => 'home#bootstrap'
  get '/status'     => 'status#index'
end
