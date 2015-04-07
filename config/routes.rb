Rails.application.routes.draw do

  scope "(:locale)", locale: /en/ do

    root 'storefront#index', as: 'storefront'

    resources :users, only: [:create, :show, :edit, :update, :destroy]
    get '/register' => 'users#new', as: 'register'
  end
end
