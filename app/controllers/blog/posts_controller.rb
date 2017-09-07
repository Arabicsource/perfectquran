class Blog::PostsController < Blog::BaseController
  def index
    @posts = Post.all
  end
end