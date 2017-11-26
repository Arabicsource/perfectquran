# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: { sign_up: 'register' },
             controllers: { registrations: 'registrations' }

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
    resources :pages, only: :show
  end

  namespace :quran do
    root 'surahs#index'
    resources :surahs, only: %i[index show]
    resources :ayahs, only: [:show]
  end

  namespace :admin do
    root 'dashboards#show'
  end

  namespace :manage do
    root 'dashboards#show'
    resources :users, :pages
  end

  get '/:surah_id/:number', to: 'quran/ayahs#show', as: :ayah_by_number
  get '/:permalink', to: 'quran/surahs#show', as: :surah

  root to: 'quran/surahs#index'
end
