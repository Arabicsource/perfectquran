# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts,
             path: '/account',
             path_names: { sign_up: 'register' },
             controllers: { registrations: 'account/registrations' }

  namespace :account do
    resource :card, only: %i[edit update]
    resources :charges, only: :index
    resource :profile, only: %i[edit update]
    resource :subscription
    resources :connections
    resource :email_preference, only: %i[edit update]
  end

  namespace :admin do
    root 'dashboards#show'
    resources :articles, :categories, :accounts, :connections
  end

  namespace :content do
    resources :articles, only: %i[index show] do
      resources :comments, only: :create
    end
  end

  namespace :hifz do
    root 'dashboards#show'

    resources :juzs, only: %i[index] do
      resources :pages, only: %i[show]
      resource :memory, only: %i[create]
    end

    resources :surahs, only: %i[index]

    resources :pages, only: %i[index show] do
      resources :ayahs, only: %i[show]
      resource :memory, only: %i[create]
    end

    resources :ayahs, only: %i[] do
      resource :memory, only: %i[create]
    end
  end

  namespace :study do
    root 'surahs#index'

    resources :surahs, only: %i[index show]
    resources :ayahs, only: %i[index show]
    resource :search, only: :show

    get '/texts/ayah/:ayah_id/translation/:translation_id', to: 'texts#show'
  end

  resources :tags, only: :create

  get '/study/ayahs/:id', to: 'study/ayahs#show', as: :ayah
  get 'auth/:provider/callback', to: 'account/connections#callback'
  get '/:surah_id/:number', to: 'study/ayahs#show', as: :ayah_by_number
  get '/:permalink', to: 'study/surahs#show', as: :surah

  root to: 'study/surahs#index'
end
