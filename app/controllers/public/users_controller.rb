class Public::UsersController < Public::Base
  def show
    @reservation = Reservation.where(user_id: params[:id])
    @current_user = current_public_user
  end

  def info
    @current_user = current_public_user
  end

  def edit
    @current_user = current_public_user
  end

  def profile
    @user = User.find(params[:id])
  end

  def withdraw
    @current_user = current_public_user
  end

  def update
    user = User.find_by(id: current_public_user.id)
    user.update(user_params)
    redirect_to public_users_info_path(user)
  end

  def withdrawal
    # 1 = 退会済み。（0 = 有効会員、2 = 強制退会済み）
    user = current_public_user
    user.update(user_status: 1)
    redirect_to action: 'withdrew'
  end

  def withdrew
  end

  private
  def user_params
    params.require(:user).permit(
      :handle_name, :profile, :profile_image_id,
      :twitter, :facebook, :instagram, :phone_number, :email_sub,
      :email, :birth_year, :birth_month, :birth_day)
  end

end