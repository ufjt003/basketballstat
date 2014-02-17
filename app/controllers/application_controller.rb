class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::StrongParameters
  include CanCan::ControllerAdditions

  check_authorization
end
