class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # 新規登録にnameを追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    mypage_end_user_path(resource)
  end
end
