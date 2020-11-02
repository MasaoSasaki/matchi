class Master::UsersController < Master::Base

  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to action: 'index'
  end

  private
  def user_params
    params.require(:user).permit(:user_status)
  end

end
