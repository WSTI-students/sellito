Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepage#index'

  resources :categories

  resources :posts

  get '/about', to: 'homepage#about'
  get '/cookies', to: 'homepage#cookies'
  get '/users/sign_in', to: 'devise/session#new'
  get '/users/sign_up', to: 'devise/registrations#new'

end
