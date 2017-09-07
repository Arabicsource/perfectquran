class Manage::PostsController < Manage::BaseController
  def index
  end
  
  def new
    @post = Post.new
  end

  def create
    flash[:success] = t 'manage.post.created'
    redirect_to manage_posts_path
  end
end