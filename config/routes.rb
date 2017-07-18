Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :surahs, only: [ :index, :show ]
      resources :ayahs, only: [ :index, :show ]
    end
  end

  root to: 'surahs#index'

  get '/:permalink', to: 'surahs#show', as: :surah


end
