class TeamsController < ApplicationController
  skip_authorization_check

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  before_filter :load_team, only: [ :show ]

  def create
    Team.create!(params[:team])
    render json: { success: true, message: 'team created' }
  end

  def show
    render json: @team
  end

  private

  def load_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name)
  end

  def record_not_found
    render json: { success: false, message: "team #{params[:id]} not found" }, status: 400
  end

  def record_invalid(error)
    render json: { success: false, message: error.message }, status: 400
  end
end
