require 'sidekiq/web'

Rails.application.routes.draw do
  use_doorkeeper
  root to: "questions#index"

  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }

  match 'users/:id/finish_sign_up', to: 'users#finish_sign_up', via: [:get, :patch], as: :finish_sign_up

  concern :ratable do
    patch 'rating-up', on: :member
    patch 'rating-down', on: :member
  end

  concern :commentable do
    resources :comments, only: :create
  end

  resources :honors,        only: :index
  resources :attachments,   only: :destroy
 
  resources :questions, except: :edit, concerns: %i[ratable commentable], shallow: true do
    resources :subscriptions, only: %i[destroy create]
    resources :answers, concerns: %i[ratable commentable], only: %i[create update destroy] do
      patch 'set_best', on: :member
    end
  end

  get '/search', to: 'search#search'

  namespace :api do
    namespace :v1 do
      resources :profiles, only: :index do
        get :me, on: :collection
      end
      resources :questions, only: %i[index show create update destroy] do
        resources :answers, only: %i[index show create update destroy], shallow: true
      end
    end
  end

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  mount ActionCable.server => '/cable'
end
