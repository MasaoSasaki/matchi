class Public::UsersController < Public::Base
  before_action :authenticate_user!, expect: %i[withdrew]
  before_action :withdrawal, only: %i[withdrew]

  def show
    @reservation_count = Reservation.where(user_id: current_user.id).count
  end

  def edit
  end

  def update
    if params[:member]
      if current_user.update(member_user_params)
        flash[:notice] = '会員情報を更新しました。'
        redirect_to user_info_path
      else
        flash.now[:danger] = '入力内容にエラーがあります。'
        render :edit
      end
    elsif params[:guest]
      if current_user.update(guest_user_params)
        flash[:notice] = '確認メールを送信しました。'
        redirect_to users_sign_up_email_notice_path(email: guest_user_params[:email])
      else
        flash.now[:danger] = '入力内容にエラーがあります。'
        render :edit
      end
    end
  end

  def info
  end

  def profile
    @user = User.find(params[:id])
  end

  def withdraw
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(user_status: "withdrew")
    sign_out @user
  end

  def withdrew
  end

  private
  def member_user_params
    params.require(:user).permit(
      :handle_name, :profile, :profile_image,
      :twitter, :facebook, :instagram, :phone_number, :email_sub,
      :email, :birth_year, :birth_month, :birth_day
    )
  end

  def guest_user_params
    params.require(:user).permit(:name_family, :name_first, :name_family_kana, :name_first_kana,
      :phone_number, :email,
      :password, :password_confirmation)
  end

end
