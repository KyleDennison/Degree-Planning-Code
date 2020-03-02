class ApplicationController < ActionController::Base

  include Pundit
  protect_from_forgery

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Make the num_required English formatter available in views
  helper_method :num_required_string

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def num_required_string(requirement)
    total_num = requirement.courses.count
    num_required = requirement.num_required

    if (num_required == 1) && (num_required == total_num)
      return "You must complete the following course."

    elsif num_required < total_num
      return "You must complete AT LEAST #{num_required} of the following courses."

    else num_required == total_num
      return "You must complete ALL of the following courses."
    end
  end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  protected
    def configure_permitted_parameters
      # Note: This must reference the devise path--not my own custom route
      devise_parameter_sanitizer.permit(:sign_up) do |new_user_params|
        new_user_params.permit(:email, :firstname, :lastname, :faculty, :password, :password_confirmation)
      end
    end

  private

  def user_not_authorized(exception)
    flash[:alert] = exception.policy.try(:error_message) || "You are not authorised to perform this action."
    redirect_to(request.referrer || root_path)
  end

end
