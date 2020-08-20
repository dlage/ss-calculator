Rails.application.routes.draw do
  devise_for :users
  get 'pages/home'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :admins
  root to: "pages#home"
end
