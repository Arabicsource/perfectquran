module Hifz
  class MemoriesController < ApplicationController
    def create
      if Juz.find(params[:juz_id]).memorize
        flash[:success] = 'Alhamdulillah'
      else
        flash[:info] = 'You must be logged in to record memories'
      end

      redirect_to hifz_juzs_path
    end
  end
end