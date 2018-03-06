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

  namespace :study do
    root 'surahs#index'

    resources :surahs, only: %i[index show]
    resources :ayahs, only: :show
  end

  namespace :quran do
    resources :memories, only: :new
    resources :texts, only: :index

    resources :ayahs, only: [] do
      scope module: :ayahs do
        resource :tag
      end
    end
  end

  get '/study/ayahs/:id', to: 'study/ayahs#show', as: :ayah
  get 'auth/:provider/callback', to: 'account/connections#callback'
  get '/:surah_id/:number', to: 'study/ayahs#show', as: :ayah_by_number
  get '/:permalink', to: 'study/surahs#show', as: :surah

  root to: 'study/surahs#index'
end
