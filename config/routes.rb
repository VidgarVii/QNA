Rails.application.routes.draw do
  get 'omniauth_callbacks_controller/github'
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }

  root to: "questions#index"

  concern :ratable do
    patch 'rating-up', on: :member
    patch 'rating-down', on: :member
  end

  concern :commentable do
    resources :comments, only: :create
  end

  resources :honors,      only: :index
  resources :attachments, only: :destroy

  resources :questions, except: :edit, concerns: %i[ratable commentable] do
    resources :answers, shallow: true, concerns: %i[ratable commentable], only: %i[create update destroy] do
      patch 'set_best', on: :member
    end
  end

  mount ActionCable.server => '/cable'
end
