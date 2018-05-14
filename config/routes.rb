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
    resources :settings, only: :index

    namespace :settings do
      resource :email, only: :edit
      resource :profile, only: :edit
      resource :quran, only: :edit
    end

    namespace :translations do
      resource :order, only: %i[update]
    end

    resources :translations, only: %i[create update destroy]
  end

  namespace :admin do
    root 'dashboards#show'
    resources :accounts, only: %i[index show]
    resources :connections, only: :index
    resources :articles, :categories, :cities, :countries, :mosques, :states
  end

  namespace :quran do
    root 'surahs#index'

    resources :surahs, only: %i[index show]

    resources :ayahs, only: [] do
      resource :bookmark, only: %i[create destroy]
    end

    get '/:permalink', to: 'surahs#show', as: :permalink
    get '/:id/:number', to: 'ayahs#show', constraints: { id: /\d+/ }
    get '/:permalink/:number', to: 'ayahs#show', as: :ayah
  end

  resources :mosques, only: :show

  get '/study/surahs/:id', to: 'quran/surahs#show'
  get '/study/ayahs/:id', to: 'quran/ayahs#show'
  get 'auth/:provider/callback', to: 'account/connections#callback'
  get '/:surah_id/:number', to: 'quran/ayahs#show', as: :ayah_by_number
  get '/:translation_id/:surah_id/:number', to: 'quran/ayahs#show'

  root to: 'home#show'
end
