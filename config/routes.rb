Rails.application.routes.draw do

  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  scope "(:locale)", locale: /en/ do

    root 'storefront#index'

    devise_for :users, skip: :omniauth_callbacks

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

    resource :localization_settings, only: [ :update ]
    resources :notifications, only: [ :index ]
    
    # Delayed job console available only in development env
    if Rails.env.development?
      match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]
    end
  end
end
