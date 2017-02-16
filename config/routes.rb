Rails.application.routes.draw do

  scope "(:locale)", locale: /en/ do

    root 'storefront#index'

    resource :session, only: [:create]
    get '/login' => 'sessions#new', as: 'login'
    delete '/logout' => 'sessions#destroy', as: 'logout'

    resources :users, only: [:create, :destroy]
    get '/register' => 'users#new', as: 'register'

    scope '/user' do
      get '/verify' => 'users#verify', as: 'verify_user'
      get '/profile' => 'users#profile', as: 'user_profile'
      put '/profile' => 'users#update_profile', as: 'update_user_profile'
      get '/settings' => 'users#settings', as: 'user_settings'
      put '/settings' => 'users#update_settings', as: 'update_user_settings'
      get '/preferences' => 'users#preferences', as: 'user_preferences'
      put '/preferences' => 'users#update_preferences', as: 'update_user_preferences'
      get '/account' => 'accounts#edit', as: 'user_account'
      put '/account/change_password' => 'accounts#change_password', as: 'change_password'
    end

    resources :passwords, only: [:create, :new, :edit, :update]

    # Delayed job console available only in development env
    if Rails.env.development?
      match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]
    end
  end
end
