class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_account

  rescue_from CanCan::AccessDenied do |_exception|
    if current_account.present?
      redirect_to root_path, alert: "Você não tem permissão para acessar esta página."
    else
      redirect_to login_path, alert: "Faça login para continuar."
    end
  end

  def current_account
    current_admin || current_user
  end

  def current_ability
    @current_ability ||= Ability.new(current_account)
  end

  def authenticate_any!
    return if current_account.present?

    redirect_to login_path, alert: "Faça login para continuar."
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      vehicles_path
    elsif resource.is_a?(User)
      vehicles_path
    else
      super
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    case resource_or_scope
    when :admin
      new_admin_session_path
    when :user
      new_user_session_path
    else
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username, :admin ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username, :admin ])
  end
end
