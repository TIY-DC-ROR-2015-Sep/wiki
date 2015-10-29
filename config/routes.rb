Rails.application.routes.draw do
  devise_for :users

  resources :articles, except: [:delete]

  root to: 'articles#index'
end
