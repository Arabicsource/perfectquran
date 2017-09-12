# frozen_string_literal: true

# :nodoc:
class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :find_ayah, except: [:show]

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = @ayah.topics.new(topic_params)
    @topic.user = current_user

    if @topic.save
      flash[:success] = t 'topic.created'
      redirect_to ayah_by_number_path(@ayah.surah.id, @ayah.number)
    else
      render :new
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:subject, :content)
  end

  def find_ayah
    @ayah = Ayah.find(params[:ayah_id])
  end
end
