class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @ayah = Ayah.find(params[:ayah_id])
    @topic = Topic.new
  end

  def create
    @ayah = Ayah.find(params[:ayah_id])
    @topic = @ayah.topics.new(topic_params)
    @topic.user = current_user
    
    if @topic.save
      flash[:success] = t 'topic.created'
      redirect_to "/#{@ayah.surah.id}/#{@ayah.number}"
    else
      render :new
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:subject, :content)
  end
end