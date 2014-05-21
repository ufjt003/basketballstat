class GamesController < ApplicationController
  skip_authorization_check

  before_filter :load_game, only: [ :show, :add_team, :remove_team, :start ]
  before_filter :load_team, only: [ :add_team, :remove_team ]

  def index
    render json: Game.all
  end

  def create
    set_game_time_if_blank
    render json: Game.create!(params[:game])
  end

  def show
    render json: @game
  end

  def add_team
    @game.add_team(@team)
    render json: { success: true, message: "a team added to a game" }
  end

  def remove_team
    @game.remove_team(@team)
    render json: { success: true, message: "a team removed from a game" }
  end

  def start
    @game.start
    render json: { success: true, message: "game started" }
  end

  def finish
    @game.finish
    render json: { success: true, message: "game finished" }
  end

  private

  def load_game
    @game = Game.find(params[:id])
  end

  def load_team
    @team = Team.find(params[:team_id])
  end

  def game_params
    params.require(:game).permit(:gametime)
  end

  def set_game_time_if_blank
    params[:game][:gametime] = DateTime.now if params[:game][:gametime].blank?
  end
end
