Rails.application.routes.draw do

  root to: 'surahs#index'

  get 'surahs/index'

  get 'surahs/show'

end
