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
    @player.player_stat.increment!(:field_goal_attempted)
    render json: { success: true, message: "player's field goal attempted incremented" }
  end

  def make_field_goal
    @player.player_stat.increment!(:field_goal_made)
    render json: { success: true, message: "player's field goal made incremented" }
  end

  def shoot_three_pointer
    @player.player_stat.increment!(:three_pointer_attempted)
    render json: { success: true, message: "player's three pointer attempted incremented" }
  end

  def make_three_pointer
    @player.player_stat.increment!(:three_pointer_made)
    render json: { success: true, message: "player's three pointer made incremented" }
  end

  def shoot_free_throw
    @player.player_stat.increment!(:free_throw_attempted)
    render json: { success: true, message: "player's free throw attempted incremented" }
  end

  def make_free_throw
    @player.player_stat.increment!(:free_throw_made)
    render json: { success: true, message: "player's free throw made incremented" }
  end

  def assist
    @player.player_stat.increment!(:assist)
    render json: { success: true, message: "player's assist incremented" }
  end

  def block
    @player.player_stat.increment!(:block)
    render json: { success: true, message: "player's block incremented" }
  end

  def steal
    @player.player_stat.increment!(:steal)
    render json: { success: true, message: "player's steal incremented" }
  end

  def rebound
    @player.player_stat.increment!(:rebound)
    render json: { success: true, message: "player's rebound incremented" }
  end

  def turnover
    @player.player_stat.increment!(:turnover)
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
