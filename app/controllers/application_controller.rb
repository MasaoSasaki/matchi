class ApplicationController < ActionController::Base
  before_action :configure_user_permitted_parameters, if: :devise_controller?
  after_action :delete_devise_flash_messages, if: :devise_controller?

  protected
  # ユーザー新規登録用許可キー
  def configure_user_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name_family, :name_first, :name_family_kana, :name_first_kana, :phone_number])
  end

  # deviseで作成されたflashのリセット（リダイレクト後にflashを引き継ぎたい場合は要改善）
  def delete_devise_flash_messages
    flash[:notice] = nil
  end
end
