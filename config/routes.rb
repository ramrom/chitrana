Rails.application.routes.draw do
  root  to: 'home#index'

  get '/status'         => 'status#index'

  get '/d3'             => 'home#d3'
  get '/d4'             => 'home#d4'
  get '/erbtest'        => 'home#erbtest'
  get '/bootstrap'      => 'home#bootstrap'
  get '/dostuff'        => 'home#dostuff'

  resources :metrics,   only: [:index, :show, :create, :update]

  controller :metrics do
    get '/get_data'       => 'metrics#get_data'
    get '/test_ajax'      => 'metrics#test_ajax'
  end

  #resources :users,   only: [:index, :show, :create, :update]

  controller :users do
    get '/users/:id/config' => 'users#config'
  end
end
