 class Manage::UsersController < Manage::BaseController
  def index
    @users = User.all
  end
 end