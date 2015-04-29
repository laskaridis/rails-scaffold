Rails.application.routes.draw do

  scope "(:locale)", locale: /en/ do

    root 'storefront#index', as: 'storefront'

    resource :session, only: [:create]
    get '/login' => 'sessions#new', as: 'login'
    delete '/logout' => 'sessions#destroy', as: 'logout'

    resources :users, only: [:create, :show, :edit, :update, :destroy]
    get '/register' => 'users#new', as: 'register'
    get '/verify/:token' => 'users#verify', as: 'verify_email'

    resources :passwords, only: [:create, :new, :edit, :update]

    # Delayed job console available only in development env
    if Rails.env.development?
      match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]
    end
  end
end
