class PlayersController < ApplicationController
  skip_authorization_check

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  before_filter :load_player, only: [ :show, :shoot, :two_pointer_attempt, :two_pointer_make,
                                      :three_pointer_attempt, :three_pointer_make,
                                      :free_throw_attempt, :free_throw_make, :assist,
                                      :block, :steal, :rebound, :turnover, :foul ]

  def index
    if params[:not_in_a_team]
      render json: Player.not_in_a_team
    else
      render json: Player.all
    end
  end

  def not_in_a_team
    render json: Player.not_in_a_team
  end

  def create
    render json: Player.create!(params[:player])
  end

  def show
    render json: @player
  end

  def two_pointer_attempt
    action
  end

  def two_pointer_make
    action
  end

  def three_pointer_attempt
    action
  end

  def three_pointer_make
    action
  end

  def free_throw_attempt
    action
  end

  def free_throw_make
    action
  end

  def assist
    action
  end

  def block
    action
  end

  def steal
    action
  end

  def rebound
    action
  end

  def turnover
    action
  end

  def foul
    action
  end

  private

  def action
    @player.send(action_name)
    render json: { success: true, message: "player's #{action_name} incremented",
                   player_stat: @player.all_time_stat,
                   team_stat: @player.team.try(:all_time_stat),
                   player_game_stat: @player.game_stat,
                   team_game_stat: @player.team.try(:game_stat) }
  end

  def load_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name, :number)
  end

  def record_not_found
    render json: { success: false, message: "player #{params[:id]} not found" }, status: 404
  end

  def record_invalid(error)
    render json: { errors: error.message }, status: 422
  end
end
