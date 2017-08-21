Rails.application.routes.draw do
  get 'menu/view'

  devise_for :users
  get 'app/new'
  get 'app/db'
  get 'app/show'
  get 'app/add'
  get 'seances/generator'
  get 'seances/generate'
  get 'seances/duplicate'
  get 'seances/duplicator'
  get 'seances/fix'

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'usr_edit', to: 'devise/registrations#edit'
    get 'sign_up', to: 'devise/registrations#new'
  end

  root to: 'app#new'

  resources :clients
  resources :doctors
  resources :seances
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
