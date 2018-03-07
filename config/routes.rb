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
      get '/security' => 'users#security', as: 'user_security'
      put '/security/change_password' => 'users#change_password', as: 'change_password'
      delete '/user' => 'users#destroy', as: 'delete_user'
    end

    get '/company/signup' => 'company_signups#welcome', as: 'company_signup'
    scope '/company/signup' do
      get '/welcome' => 'company_signups#welcome', as: 'company_signup_welcome'
      get '/business' => 'company_signups#business', as: 'company_signup_business'
      post 'business' => 'company_signups#create_business'
      get '/address' => 'company_signups#address', as: 'company_signup_address'
      post '/address' => 'company_signups#create_address'
      get '/contact' => 'company_signups#contact', as: 'company_signup_contact'
      post '/contact' => 'company_signups#create_contact'
    end
    

    resources :passwords, only: [:create, :new, :edit, :update]

    # Delayed job console available only in development env
    if Rails.env.development?
      match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]
    end
  end
end
