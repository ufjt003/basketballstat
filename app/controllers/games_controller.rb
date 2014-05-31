class GamesController < ApplicationController
  skip_authorization_check

  before_filter :load_game, only: [ :show, :add_home_team, :add_away_team, :remove_team, :start, :destroy ]
  before_filter :load_team, only: [ :add_home_team, :add_away_team, :remove_team ]
  before_filter :load_home_team, only: [ :create ]
  before_filter :load_away_team, only: [ :create ]
  before_filter :set_game_time_if_blank, only: [ :create ]

  def index
    render json: Game.all
  end

  def destroy
    render json: @game.destroy
  end

  def create
    @game = Game.new(params[:game])
    @game.save!
    begin
      @game.add_home_team(@home_team) if @home_team
      @game.add_away_team(@away_team) if @away_team
      render json: @game
    rescue Errors::InvalidMethodCallError, ActiveRecord::RecordInvalid => e
      @game.delete
      invalid_method_call(e)
    end
  end

  def show
    render json: @game
  end

  def add_home_team
    @game.add_home_team(@team)
    render json: { success: true, message: "a home team added to a game" }
  end

  def add_away_team
    @game.add_away_team(@team)
    render json: { success: true, message: "an away added to a game" }
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

  def load_home_team
    @home_team = Team.find(params[:home_team_id]) if params[:home_team_id]
  end

  def load_away_team
    @away_team = Team.find(params[:away_team_id]) if params[:away_team_id]
  end

end
