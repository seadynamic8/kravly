Wishproto::Application.routes.draw do

  root 'public#index'
  
  mount Ckeditor::Engine => '/ckeditor'

  get 'about', to: 'public#about', as: :about
  get 'intro', to: 'public#intro', as: :intro
  
  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :sessions, only: :create
  get "login", to: "sessions#new", as: :login
  get "logout", to: "sessions#destroy", as: :logout
  # get "signup", to: "sessions#signup", as: :signup

  resources :comments, only: [:create, :edit, :update, :destroy]
  get "/:idea_id/comments/:id/reply", to: "comments#reply", as: :reply_comment

  resources :ideas do
    get 'vote', on: :member
  end

  get ':id(.:format)', to: "users#boards"

  #Keep on bottom, these will catch all
  resources :users, only: [:index, :new, :create]
  resources :users, path: '/', except: [:index, :new, :create, :show]
  resources :users, path: '/', only: [] do
    member do
      get 'settings'
      get 'boards'
      get 'ideas'
      get 'votes'
    end
    resources :boards, only: [:index, :new, :create]
    resources :boards, path: '/', except: [:index, :new, :create]
  end

end
