Rails.application.routes.draw do
  # devise_for :users

  root 'welcome#index'
  get 'mockup', to: 'pitch#index'

  get 'employment/index'
  get 'pitch/index'
  get 'pregnancy/index'
  get 'veterans/index'
  get 'freeclinics/index'
  get 'welcome/index'

  get 'signup', to: 'end_user#new', as: :new_end_user
end
