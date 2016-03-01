Rails.application.routes.draw do
  
  resources :employees do
    get 'transfer', 'dismiss', on: :member
    patch 'move', 'fire', on: :member
  end
  
  resources :departments, only: [:index, :create, :new]
  resources :jobs, only: [:index, :create, :new]
  
  root to: 'employees#index'
  
end
