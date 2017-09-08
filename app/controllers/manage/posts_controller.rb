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
    authorize [:manage, Post]
  end

  def create
    authorize [:manage, Post]    
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:success] = t 'manage.post.created'
      redirect_to manage_posts_path
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end