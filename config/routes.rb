Rails.application.routes.draw do
  root  to: 'home#index'

  get '/d3'         => 'home#d3'
  get '/chart_data' => 'home#chart_data'
  get '/bootstrap'  => 'home#bootstrap'
  get '/status'     => 'status#index'

  get '/user_config' => 'user#config'
end
