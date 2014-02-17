class SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, :only => [:create ]
  include Devise::Controllers::Helpers

  def create
    resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    render json: { success: 'true', email: resource.email }
  end

  def destroy
    sign_out(resource_name)
    render json: { success: 'true', message: 'signed out' }
  end
end
