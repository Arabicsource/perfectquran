# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts,
             path: '/account',
             path_names: { sign_up: 'register' },
             controllers: { registrations: 'account/registrations' }

  namespace :account do
    resource :card, only: %i[edit update]
    resource :profile, only: %i[edit update]
    resources :connections
    resource :email_preference, only: %i[edit update]
    resource :quran_preference, only: %i[edit]

    namespace :translations do
      resource :order, only: %i[update]
    end

    resources :translations, only: %i[create update destroy]
  end

  namespace :admin do
    root 'dashboards#show'
    resources :articles, :categories, :accounts, :connections

    resources :mosques, only: %i[index new create]
    resources :countries, only: %i[index new create]
    resources :states, only: %i[index new create]
    resources :cities, only: %i[index new create]
  end

  namespace :study do
    root 'surahs#index'

    resources :surahs, only: %i[index show]
    resources :ayahs, only: %i[index show]
  end

  get '/study/ayahs/:id', to: 'study/ayahs#show', as: :quran_ayah
  get 'auth/:provider/callback', to: 'account/connections#callback'
  get '/:surah_id/:number', to: 'study/ayahs#show', as: :ayah_by_number
  get '/:translation_id/:surah_id/:number', to: 'study/ayahs#show'
  get '/:permalink', to: 'study/surahs#show', as: :surah

  root to: 'study/surahs#index'
end
