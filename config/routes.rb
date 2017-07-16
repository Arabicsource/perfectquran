Rails.application.routes.draw do

  root to: 'surahs#index'

  get '/:permalink', to: 'surahs#show', as: :surah

end
