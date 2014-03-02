class GamesController < ApplicationController
  skip_authorization_check

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  before_filter :load_game, only: [ :show, :add_team, :remove_team ]

  def create
    Game.create!(params[:game])
    render json: { success: true, message: 'game created' }
  end

  def show
    render json: @game
  end

  def add_team
    reject_if_two_teams_are_already_in_the_game
    if @game.add_team(Team.find(params[:team_id]))
      render json: { success: true, message: "a team added to a game" }
    end
  end

  def remove_team
    if @game.remove_team(Team.find(params[:team_id]))
      render json: { success: true, message: "a team removed from a game" }
    end
  end

  private

  def load_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:gametime)
  end

  def record_not_found(error)
    render json: { success: false, message: error.message }, status: 400
  end

  def record_invalid(error)
    render json: { success: false, message: error.message }, status: 400
  end

  def reject_if_two_teams_are_already_in_the_game
    if @game.teams.count >= 2
      render json: { success: false, message: "game has 2 teams already" }, status: 400
      return
    end
  end

end
