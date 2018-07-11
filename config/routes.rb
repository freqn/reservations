Rails.application.routes.draw do
  root 'welcome#index'
  resources :tables
  resources :reservations
end
