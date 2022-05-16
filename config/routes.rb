# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  put 'locales/:locale', to: 'locales#update', as: :locale,
                         constraints: { locale: /#{I18n.available_locales.join('|')}/ }

  # root 'welcome_pages#welcome'
  devise_scope :user do
    authenticated  do
      root to: 'books#index', as: :authenticated_root
    end

    unauthenticated do
      root 'welcome_pages#welcome', as: :unauthenticated_root
    end
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get 'welcome', to: 'welcome_pages#welcome', as: :welcome
  get 'download', to: 'books#download', as: :download

  resources :profiles, only: %i[show edit update]
  resources :categories
  resources :books
end
