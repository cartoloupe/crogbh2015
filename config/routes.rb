Rails.application.routes.draw do
  root 'welcome#index'

  get 'mockup', to: 'pitch#index'

  get ':category', to: 'service#category', as: :category

  constraints UserTypeIncluding.new(:none) do
    get  'signup', to: 'end_user#new',   as: :new_end_user
    post 'signup', to: 'end_user#create'
    get  'login', to:  'session#new', as: :login
    post 'login', to:  'session#create'
  end

  constraints UserTypeIncluding.new(:end_user) do
     get   'account',      to: 'end_user#show', as: :end_user
     get   'account/edit', to: 'end_user#edit'
     patch 'account/edit', to: 'end_user#update'
  end
end
