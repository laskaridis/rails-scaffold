Rails.application.routes.draw do

  scope "(:locale)", locale: /en/ do

    root 'storefront#index'

    devise_for :users

    scope '/account' do
      get '/profile' => 'accounts#profile', as: 'account_profile'
      put '/profile' => 'accounts#update_profile', as: 'update_account_profile'
      get '/settings' => 'accounts#settings', as: 'account_settings'
      put '/settings' => 'accounts#update_settings', as: 'update_account_settings'
      get '/preferences' => 'accounts#preferences', as: 'account_preferences'
      put '/preferences' => 'accounts#update_preferences', as: 'update_account_preferences'
      get '/security' => 'accounts#security', as: 'account_security'
      put '/security/change_password' => 'accounts#change_password', as: 'change_password'
    end
    delete '/account' => 'accounts#destroy', as: 'delete_account'

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
    
    # Delayed job console available only in development env
    if Rails.env.development?
      match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]
    end
  end
end
