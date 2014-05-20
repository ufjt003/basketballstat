class TeamsController < ApplicationController
  skip_authorization_check

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
end
