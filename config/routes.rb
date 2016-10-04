Rails.application.routes.draw do
  root  to: 'home#index'

  get '/status'         => 'status#index'

  get '/d3'             => 'home#d3'
  get '/d4'             => 'home#d4'
  get '/bootstrap'      => 'home#bootstrap'

  resources :metrics,   only: [:index, :show, :create, :update]

  controller :metrics do
    get '/get_data'       => 'metrics#get_data'
    get '/test_ajax'      => 'metrics#test_ajax'
  end

  get '/user_config' => 'users#config'
end
