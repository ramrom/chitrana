Rails.application.routes.draw do
  root  to: 'home#index'

  get '/status'         => 'status#index'

  get '/d3'             => 'home#d3'
  get '/d4'             => 'home#d4'
  get '/bootstrap'      => 'home#bootstrap'

  resources :metrics,   only: [:index, :show, :create, :update]

  controller :metrics
  get '/metric_data'    => 'metric#metric_data'
  get '/test_ajax'      => 'metric#test_ajax'

  get '/user_config' => 'user#config'
end
