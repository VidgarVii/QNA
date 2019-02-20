Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"

  resources :attachments, only: :destroy

  resources :questions, except: :edit do
    resources :answers, shallow: true, only: %i[create update destroy] do
      patch 'set_best', on: :member
    end
  end
end
