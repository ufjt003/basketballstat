class TeamsController < ApplicationController
  skip_authorization_check

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  before_filter :load_team, only: [ :show, :add_player, :remove_player ]

  def create
    Team.create!(params[:team])
    render json: { success: true, message: 'team created' }
  end

  def show
    render json: @team
  end

  def add_player
    if @team.add_player(Player.find(params[:player_id]))
      render json: { success: true, message: "a player added to a team" }
    end
  end

  def remove_player
    if @team.remove_player(Player.find(params[:player_id]))
      render json: { success: true, message: "a player removed from a team" }
    end
  end

  private

  def load_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name)
  end

  def record_not_found(error)
    render json: { success: false, message: error.message }, status: 400
  end

  def record_invalid(error)
    render json: { success: false, message: error.message }, status: 400
  end
end
