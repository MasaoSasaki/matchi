# frozen_string_literal: true

class Public::Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :delete_devise_flash_messages, only: %i[email_notice]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    if params[:guest]
      @user = User.new(name_family: "", name_first: "", name_family_kana: "", name_first_kana: "", phone_number: "",
      handle_name: "guest#{ SecureRandom.random_number(9999) }",
      user_status: "guest",
      password: SecureRandom.alphanumeric(6), confirmed_at: DateTime.now)
      @user.email =  "guest#{ @user.handle_name }@guest.com"
      @user.save
      sign_in @user
      flash[:notice] = 'ゲスト会員でログインしました。'
      redirect_to root_path
      return
    end
    @user = User.new(sign_up_params)
    render :new and return if params[:back]
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  def confirm
    @user = User.new(sign_up_params)
    if @user.invalid?
      flash.now[:danger] = '入力内容にエラーがあります。'
      render :new
      return
    end
  end

  def email_notice
    redirect_to expired_path unless params[:email]
  end

  def complete
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # アカウント編集後
  def after_update_path_for(resource)
    user_info_path
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    users_sign_up_email_notice_path(email: resource.email)
  end

end
