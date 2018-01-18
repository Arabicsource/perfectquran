# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :accounts do
    resource :card, only: %i[edit update]
    resources :charges, only: :index
    resource :profile, only: %i[edit show update]
    resource :subscription
    resources :connections
  end

  namespace :admin do
    root 'dashboards#show'
    resources :articles, :categories, :accounts
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :surahs, only: %i[index show]
      resources :ayahs, only: %i[index show]
      get '/surah/:surah_id/ayah/:ayah_number', to: 'ayahs#show'
      get '/text/ayah/:ayah_id/quran/:translation_id', to: 'texts#show'
      get '/text/ayah/:ayah_id/translation/:translation_id', to: 'texts#show'
    end
  end

  namespace :content do
    resources :articles, only: %i[index show] do
      resources :comments, only: :create
    end
  end

  namespace :quran do
    root 'surahs#index'

    resources :memories, only: :new

    resources :surahs, only: %i[index show] do
      scope module: :surahs do
        resource :memories
      end
    end

    resources :ayahs, only: [:show] do
      scope module: :ayahs do
        resource :memories, :bookmarks
      end
    end
  end

  devise_for :accounts,
             path: '',
             path_names: { sign_up: 'register' },
             controllers: { registrations: 'registrations' }

  get 'auth/:provider/callback', to: 'accounts/connections#callback'
  get '/:surah_id/:number', to: 'quran/ayahs#show', as: :ayah_by_number
  get '/:permalink', to: 'quran/surahs#show', as: :surah

  root to: 'quran/surahs#index'
end
