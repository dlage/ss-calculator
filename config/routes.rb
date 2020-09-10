Rails.application.routes.draw do
  devise_for :users
  get 'pages/home'
  get '/tax_references', to: 'tax_references#index'
  get '/tax_references/:year', to: 'tax_references#show'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :admins
  root to: "pages#home"
end
