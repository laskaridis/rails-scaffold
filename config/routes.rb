Rails.application.routes.draw do

  scope "(:locale)", locale: /en/ do

    root 'storefront#index', as: 'storefront'

    resource :session, only: [:create]
    get '/login' => 'sessions#new', as: 'login'
    delete '/logout' => 'sessions#destroy', as: 'logout'

    resources :users, only: [:create, :destroy]
    get '/register' => 'users#new', as: 'register'
    get '/verify/:token' => 'users#verify', as: 'verify_email'
    get '/users/edit' => 'users#edit', as: 'edit_user'
    put '/users' => 'users#update', as: 'update_user'
    get '/account' => 'accounts#edit', as: 'edit_account'
    put '/account/change_password' => 'accounts#change_password', as: 'change_password'

    resources :passwords, only: [:create, :new, :edit, :update]

    # Delayed job console available only in development env
    if Rails.env.development?
      match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]
    end
  end
end
