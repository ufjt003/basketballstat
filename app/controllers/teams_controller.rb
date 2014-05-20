class TeamsController < ApplicationController
  skip_authorization_check

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  before_filter :load_team, only: [ :show, :add_player, :remove_player ]
  before_filter :load_player, only: [ :add_player, :remove_player ]

  def index
    render json: Team.all
  end

  def create
    render json: Team.create!(params[:team])
  end

  def show
    render json: @team
  end

  def add_player
    action
  end

  def remove_player
    action
  end

  private

  def action
    if @team.send(action_name, @player)
      render json: { success: true, message: "#{action_name} successful" }
    end
  end

  def load_team
    @team = Team.find(params[:id])
  end

  def load_player
    @player = Player.find(params[:player_id])
  end

  def team_params
    params.require(:team).permit(:name)
  end

  def record_not_found(error)
    render json: { success: false, message: error.message }, status: 404
  end

  def record_invalid(error)
    render json: { errors: error.message }, status: 422
  end
end
