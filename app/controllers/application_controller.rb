class ApplicationController < ActionController::API
  include AbstractController::Layouts
  include ActionController::MimeResponds
  include ActionController::RequestForgeryProtection
  include ActionController::StrongParameters
  include CanCan::ControllerAdditions

  check_authorization

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  def default_serializer_options
    { root: false }
  end
end
