Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"

  concern :ratable do
    patch 'rating-up', on: :member
    patch 'rating-down', on: :member
  end

  resources :honors,      only: :index
  resources :attachments, only: :destroy

  resources :questions, except: :edit, concerns: :ratable do
    resources :answers, shallow: true, concerns: :ratable, only: %i[create update destroy] do
      patch 'set_best', on: :member
    end
  end
end
