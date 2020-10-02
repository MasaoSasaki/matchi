class ApplicationController < ActionController::Base

  before_action :configure_user_permitted_parameters, if: :devise_controller?
  # before_action :configure_restaurant_permitted_parameters, if: :devise_controller?
  # before_action :basic_auth
  # protect_from_forgery with: :exception

  # Basic認証設定
  # def basic_auth
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
  #   end
  # end

  # Google Cloud PlatformのAPIキーをJSON形式で保存（gem'gon'）
  def api
    gon.google_platform_api_key = ENV['GOOGLE_PLATFORM_API_KEY']
  end

  protected
  # ユーザー新規登録用許可キー
  def configure_user_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name_family, :name_first, :name_family_kana, :name_first_kana, :phone_number])
  end

  # 店舗新規登録用許可キー
  # def configure_restaurant_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone_number, :postal_code])
  # end

end
