Rails.application.routes.draw do

  devise_for :users, path: ''
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :surahs, only: [ :index, :show ]
      resources :ayahs, only: [ :index, :show ] do
        resources :favorites
        resources :memories
      end
      get '/surah/:surah_id/ayah/:ayah_number', to: 'ayahs#show'
      get '/text/ayah/:ayah_id/quran/:quran_id', to: 'texts#show'
    end
  end

  root to: 'surahs#index'

  get '/:permalink', to: 'surahs#show', as: :surah


end
