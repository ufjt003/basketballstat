class ApplicationController < ActionController::API
  include AbstractController::Layouts
  include ActionController::MimeResponds
  include ActionController::RequestForgeryProtection
  include ActionController::StrongParameters
  include CanCan::ControllerAdditions

  check_authorization

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from Errors::InvalidMethodCallError, with: :invalid_method_call

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  protected

  def record_not_found
    render json: { success: false, message: "player #{params[:id]} not found" }, status: 404
  end

  def record_invalid(error)
    render json: { errors: error.message }, status: 422
  end

  def invalid_method_call(error)
    render json: { success: false, message: error.message }, status: 400
  end

end
