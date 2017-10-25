# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: { sign_up: 'register' },
             controllers: { registrations: 'registrations' }

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :surahs, only: %i[index show]
      resources :ayahs, only: %i[index show] do
        resources :favorites
        resources :memories
      end
      get '/surah/:surah_id/ayah/:ayah_number', to: 'ayahs#show'
      get '/text/ayah/:ayah_id/quran/:translation_id', to: 'texts#show'
      get '/text/ayah/:ayah_id/translation/:translation_id', to: 'texts#show'
    end
  end

  namespace :content do
    resources :pages, only: :show
  end

  namespace :quran do
    root 'surahs#index'
    resources :surahs, only: %i[index show]
    resources :ayahs, only: [:show]
  end

  namespace :manage do
    root 'dashboards#show'
    resources :users, :posts, :pages, :categories, :comments

    namespace :comment do
      resources :flags
    end
  end

  namespace :blog do
    resources :categories, only: :show
    resources :posts, only: :show
  end

  resources :settings, only: :index
  namespace :settings do
    resource :general, only: %i[edit update]
  end

  resources :comments do
    resources :flags, only: %i[new create]
  end

  resources :searches

  resources :posts do
    resources :comments
  end

  resources :ayahs do
    resources :comments
  end

  resources :pages, only: :show
  resources :contacts, only: %i[new create]
  resources :users, only: :show

  get '/blog', to: 'blog/posts#index', as: :blog
  get '/:surah_id/:number', to: 'quran/ayahs#show', as: :ayah_by_number
  get '/:permalink', to: 'quran/surahs#show', as: :surah

  root to: 'quran/surahs#index'
end
