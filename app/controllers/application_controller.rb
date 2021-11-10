class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(_resource)
    ogiris_path # ログイン後大喜利一覧に遷移
  end

  def after_sign_out_path_for(_resource)
    root_path # ログアウト後ホーム画面に
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password])
  end
end
