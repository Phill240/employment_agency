Rails.application.routes.draw do
  
  resources :employees, :path => '/' do
    get 'transfer', 'dismiss', on: :member
    patch 'move', 'fire', on: :member
  end
  
end
