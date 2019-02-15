Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"

  resources :questions, except: :edit do
    resources :answers, shallow: true, only: %i[create update destroy]
  end

end
