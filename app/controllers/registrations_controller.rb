class RegistrationsController < Devise::RegistrationsController
  include Devise::Controllers::Helpers

  prepend_before_filter :require_no_authentication, :only => [:create ]
  before_filter :load_user, only: [:update]

  def create
    user = User.new(params.require(:user).permit(:email, :password, :name))
    if user.save
      render json: user.as_json(authenticatable_salt: user.authenticatable_salt, email: user.email, name: user.name), status: 201
    else
      render json: user.errors, status: 400
    end
  end

  def update
    if @user.update_attributes(params.require(:user).permit(:email, :password))
      render json: @user.as_json(email: @user.email)
    else
      render json: @user.errors, status: 400
    end
  end

  private

  def load_user
    @user = User.find(params[:id])
  end
end
