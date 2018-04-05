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
    resource :quran_preference, only: %i[edit]

    namespace :translations do
      resource :order, only: %i[update]
    end

    resources :translations, only: %i[create update destroy]
  end

  namespace :admin do
    root 'dashboards#show'
    resources :articles, :categories, :accounts, :connections
    resources :tags, only: %i[index]
  end

  namespace :content do
    resources :articles, only: %i[index show] do
      resources :comments, only: :create
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

  get '/blog', to: 'content/articles#index'
  get '/study/ayahs/:id', to: 'study/ayahs#show', as: :quran_ayah
  get 'auth/:provider/callback', to: 'account/connections#callback'
  get '/:surah_id/:number', to: 'study/ayahs#show', as: :ayah_by_number
  get '/:translation_id/:surah_id/:number', to: 'study/ayahs#show'
  get '/:permalink', to: 'study/surahs#show', as: :surah

  root to: 'study/surahs#index'
end
