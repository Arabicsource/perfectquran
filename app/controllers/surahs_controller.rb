# frozen_string_literal: true

# :nodoc:
class SurahsController < ApplicationController
  def index
    @surahs = Surah.all
    render layout: 'fullpage'
  end

  def show
    @surah = Surah.find_by(permalink: params[:permalink])
  end
end
