class RegistrationsController < Devise::RegistrationsController
  include Devise::Controllers::Helpers

  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

  prepend_before_filter :require_no_authentication, :only => [:create ]
  before_filter :load_user, only: [:update]
  skip_authorization_check

  def create
    @user = User.new(params.require(:user).permit(:email, :password, :name))
    @user.save!
    render json: @user.as_json(authenticatable_salt: @user.authenticatable_salt, email: @user.email, name: @user.name), status: 201
  end

  def update
    @user.update_attributes!(params.require(:user).permit(:email, :password))
    render json: @user.as_json(email: @user.email)
  end

  private

  def invalid_record
    render json: @user.errors, status: 400
  end

  def load_user
    @user = User.find(params[:id])
  end
end
