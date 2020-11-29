# frozen_string_literal: true

class Public::Users::ConfirmationsController < Devise::ConfirmationsController
  after_action :delete_devise_flash_messages, only: %i[create]

  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  protected

  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    flash[:success] = '確認メールを送信しました。'
    new_user_confirmation_path(resource_name)
  end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    sign_in resource
    if resource.user_status == 'guest'
      resource.update(user_status: 'member')
    end
    users_sign_up_complete_path
  end
end
