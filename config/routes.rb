Rails.application.routes.draw do
  resources :memories
  devise_for :users
  root 'memories#index'
end
