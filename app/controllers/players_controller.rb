class PlayersController < ApplicationController
  skip_authorization_check

  before_filter :load_player, only: [ :show, :shoot, :two_pointer_attempt, :two_pointer_make,
                                      :three_pointer_attempt, :three_pointer_make,
                                      :free_throw_attempt, :free_throw_make, :assist,
                                      :block, :steal, :rebound, :turnover, :foul, :undo ]

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

  def undo
    @player.undo
    render json: @player.reload
  end

  private

  def action
    @player.send(action_name)
    render json: @player.reload
  end

  def load_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name, :number)
  end

end
