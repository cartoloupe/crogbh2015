Rails.application.routes.draw do
  # devise_for :users

  root 'welcome#index'
  get 'mockup', to: 'pitch#index'
  get 'signup', to: 'end_user#new', as: :new_end_user

  get ':category', to: 'service#category', as: :category
end
