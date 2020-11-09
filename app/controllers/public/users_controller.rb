class Public::UsersController < Public::Base

  before_action :authenticate_user!, expect: %i[withdrew]
  before_action :withdrawal, only: %i[withdrew]

  def show
    @reservation_count = Reservation.where(user_id: current_user.id).count
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to user_info_path
    else
      render :edit
    end
  end

  def info
  end

  def profile
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
  end

  def withdrawal
    @user = User.find(params[:id])
    # 1 = 退会済み。（0 = 有効会員、2 = 強制退会）
    @user.update(user_status: 1)
  end

  def withdrew
  end

  private
  def user_params
    params.require(:user).permit(
      :handle_name, :profile, :profile_image,
      :twitter, :facebook, :instagram, :phone_number, :email_sub,
      :email, :birth_year, :birth_month, :birth_day
    )
  end

end
