Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"

  resources :questions, except: :edit do
    post 'best_answer', on: :member
    resources :answers, shallow: true, only: %i[create update destroy]
  end

end
