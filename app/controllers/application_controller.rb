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
  rescue_from ActionController::ParameterMissing, with: :missing_param

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  protected

  def missing_param(e)
    render json: { errors: e.message }, status: 400
  end

  def record_not_found(e)
    render json: { errors: e.message }, status: 404
  end

  def record_invalid(error)
    render json: { errors: error.message }, status: 422
  end

  def invalid_method_call(error)
    render json: { errors: error.message }, status: 400
  end

  def default_serializer_options
    { root: false }
  end
end
