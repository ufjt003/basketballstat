class PlayersController < ApplicationController
  skip_authorization_check

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  before_filter :load_player, only: [ :show, :shoot, :make_field_goal,
                                      :shoot_three_pointer, :make_three_pointer,
                                      :shoot_free_throw, :make_free_throw, :assist,
                                      :block, :steal, :rebound, :turnover ]

  def create
    Player.create!(params[:player])
    render json: { success: true, message: 'player created' }
  end

  def show
    render json: @player
  end

  def shoot
    @player.shoot
    render json: { success: true, message: "player's field goal attempted incremented" }
  end

  def make_field_goal
    @player.make_field_goal
    render json: { success: true, message: "player's field goal made incremented" }
  end

  def shoot_three_pointer
    @player.shoot_three_pointer
    render json: { success: true, message: "player's three pointer attempted incremented" }
  end

  def make_three_pointer
    @player.make_three_pointer
    render json: { success: true, message: "player's three pointer made incremented" }
  end

  def shoot_free_throw
    @player.shoot_free_throw
    render json: { success: true, message: "player's free throw attempted incremented" }
  end

  def make_free_throw
    @player.make_free_throw
    render json: { success: true, message: "player's free throw made incremented" }
  end

  def assist
    @player.assist
    render json: { success: true, message: "player's assist incremented" }
  end

  def block
    @player.block
    render json: { success: true, message: "player's block incremented" }
  end

  def steal
    @player.steal
    render json: { success: true, message: "player's steal incremented" }
  end

  def rebound
    @player.rebound
    render json: { success: true, message: "player's rebound incremented" }
  end

  def turnover
    @player.turnover
    render json: { success: true, message: "player's turnover incremented" }
  end

  private

  def load_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name, :number)
  end

  def record_not_found
    render json: { success: false, message: "player #{params[:id]} not found" }, status: 400
  end

  def record_invalid(error)
    render json: { success: false, message: error.message }, status: 400
  end
end
