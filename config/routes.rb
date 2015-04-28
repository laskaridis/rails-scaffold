Rails.application.routes.draw do

  scope "(:locale)", locale: /en/ do

    root 'storefront#index', as: 'storefront'

    resource :session, only: [:create]
    get '/login' => 'sessions#new', as: 'login'
    delete '/logout' => 'sessions#destroy', as: 'logout'

    resources :users, only: [:create, :show, :edit, :update, :destroy]
    get '/register' => 'users#new', as: 'register'
    get '/verify/:token' => 'users#verify', as: 'verify_email'
  end
end
