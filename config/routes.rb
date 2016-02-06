Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations' }, path: "auth", path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  resources :users, only: [:show]

  post :incoming, to: 'incoming#create'

  resources :topics do
    resources :bookmarks, except: [:index] do
      resources :likes, only: [:create, :destroy]
    end
  end

  root to: 'topics#index'
end
