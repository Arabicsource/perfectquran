class TopicsController < ApplicationController

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @ayah = Ayah.find(params[:ayah_id])
  end

  def create
    @ayah = Ayah.find(params[:ayah_id])
    @topic = @ayah.topics.new(topic_params)
    @topic.user = current_user
    
    if @topic.save
      flash[:success] = 'Topic created'
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