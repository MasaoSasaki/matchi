# frozen_string_literal: true

class Public::Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_user, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    redirect_to new_user_session_path and return if flash[:error]
    super
  end

  # DELETE /resource/sign_out
  def destroy
    # ゲスト会員ならログアウトと同時に会員情報を削除
    User.find(current_user.id).destroy if current_user.user_status == "guest"
    super
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def reject_user
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && @user.active_for_authentication? == false
        flash[:error] = "退会済みのユーザーです。"
      elsif !@user.valid_password?(params[:user][:password])
        flash[:error] = "IDまたはパスワードが違います。"
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
