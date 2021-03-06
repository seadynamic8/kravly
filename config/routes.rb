Wishproto::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  root 'public#index'
  
  mount Ckeditor::Engine => '/ckeditor'

  get 'discover', to: 'public#discover', as: :discover
  get 'about', to: 'public#about', as: :about
  get 'intro', to: 'public#intro', as: :intro
  get 'basics', to: 'public#basics', as: :basics
  get 'terms', to: 'public#terms', as: :terms
  get 'privacy', to: 'public#privacy', as: :privacy
  
  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :sessions, only: :create
  get "login", to: "sessions#new", as: :login
  get "logout", to: "sessions#destroy", as: :logout

  resources :comments, only: [:create, :edit, :update, :destroy]
  get "/:idea_id/comments/:id/reply", to: "comments#reply", as: :reply_comment

  resources :categories
  get "/category/boards/:category_id", to: "boards#index", as: :category_boards
  get "/all/:category_id", to: "public#discover", as: :category_index

  resources :ideas do
    get 'vote', on: :member
  end

  #Keep on bottom, these will catch all
  resources :users, only: [:index, :new, :create]
  resources :users, path: '/', except: [:index, :new, :create, :show]
  resources :users, path: '/', only: [] do
    member do
      get 'settings'
      get 'boards'
      get 'ideas'
      get 'votes'
      get 'change_password'
      patch 'update_password'
    end

    resources :boards, only: [ :new, :create]
    resources :boards, path: '/', except: [:index, :new, :create]
  end
  resources :boards, only: [:index]
  
  get ':id(.:format)', to: "users#boards"
end
