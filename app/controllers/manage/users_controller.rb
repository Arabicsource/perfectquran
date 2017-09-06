 class Manage::UsersController < Manage::BaseController
  def index
    authorize User
    @users = User.all
  end
 end