Rails.application.routes.draw do
  resources :tables do
    resources :reservations
  end
end
