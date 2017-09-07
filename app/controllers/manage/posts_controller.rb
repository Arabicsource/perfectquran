class Manage::PostsController < Manage::BaseController
  def index
    authorize [:manage, Post]
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    authorize [:manage, Post]
  end
  
  def new
    @post = Post.new
  end

  def create
    flash[:success] = t 'manage.post.created'
    redirect_to manage_posts_path
  end
end