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
      get '/text/ayah/:ayah_id/quran/:quran_id', to: 'texts#show'
    end
  end

  namespace :manage do
    resources :dashboards, only: :index
    resources :users, :posts, :pages, :categories
  end

  namespace :blog do
    resources :categories, only: :show
    resources :posts, only: :show do
      resources :comments, only: :create
    end
  end

  resources :searches
  resources :ayahs
  resources :pages, only: :show
  resources :contacts, only: %i[new create]
  resources :users, only: :show

  get '/blog', to: 'blog/posts#index', as: :blog
  get '/:surah_id/:number', to: 'ayahs#show', as: :ayah_by_number
  get '/:permalink', to: 'surahs#show', as: :surah

  root to: 'surahs#index'
end
