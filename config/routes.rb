Rails.application.routes.draw do
  resources :campaigns, only: [:index, :show, :create, :update, :destroy]
end
