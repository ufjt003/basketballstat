class PlayersController < ApplicationController
  skip_authorization_check

  before_filter :load_player, only: [ :show, :shoots, :makes_field_goal,
                                      :shoots_three_pointer, :makes_three_pointer,
                                      :shoots_free_throw, :makes_free_throw, :assist,
                                      :block, :steal, :rebound, :turnover ]

  def create
    if Player.create(params[:player])
      render json: { success: true, message: 'player created' }
    else
      render json: { success: false, message: 'failed to create a player' }, status: 400
    end
  end

  def show
    render json: @player
  end

  def shoots
    if @player.player_stat.increment!(:field_goal_attempted)
      render json: { success: true, message: "player's field goal attempted incremented" }
    else
      render json: { success: false, message: "player's field goal attempted increment failed" }, status: 400
    end
  end

  def makes_field_goal
    if @player.player_stat.increment!(:field_goal_made)
      render json: { success: true, message: "player's field goal made incremented" }
    else
      render json: { success: false, message: "player's field goal made increment failed" }, status: 400
    end
  end

  def shoots_three_pointer
    if @player.player_stat.increment!(:three_pointer_attempted)
      render json: { success: true, message: "player's three pointer attempted incremented" }
    else
      render json: { success: false, message: "player's three pointer attempted increment failed" }, status: 400
    end
  end

  def makes_three_pointer
    if @player.player_stat.increment!(:three_pointer_made)
      render json: { success: true, message: "player's three pointer made incremented" }
    else
      render json: { success: false, message: "player's three pointer made increment failed" }, status: 400
    end
  end

  def shoots_free_throw
    if @player.player_stat.increment!(:free_throw_attempted)
      render json: { success: true, message: "player's free throw attempted incremented" }
    else
      render json: { success: false, message: "player's free throw attempted increment failed" }, status: 400
    end
  end

  def makes_free_throw
    if @player.player_stat.increment!(:free_throw_made)
      render json: { success: true, message: "player's free throw made incremented" }
    else
      render json: { success: false, message: "player's free throw made increment failed" }, status: 400
    end
  end

  def assist
    if @player.player_stat.increment!(:assist)
      render json: { success: true, message: "player's assist incremented" }
    else
      render json: { success: false, message: "player's assist increment failed" }, status: 400
    end
  end

  def block
    if @player.player_stat.increment!(:block)
      render json: { success: true, message: "player's block incremented" }
    else
      render json: { success: false, message: "player's block increment failed" }, status: 400
    end
  end

  def steal
    if @player.player_stat.increment!(:steal)
      render json: { success: true, message: "player's steal incremented" }
    else
      render json: { success: false, message: "player's steal increment failed" }, status: 400
    end
  end

  def rebound
    if @player.player_stat.increment!(:rebound)
      render json: { success: true, message: "player's rebound incremented" }
    else
      render json: { success: false, message: "player's rebound increment failed" }, status: 400
    end
  end

  def turnover
    if @player.player_stat.increment!(:turnover)
      render json: { success: true, message: "player's turnover incremented" }
    else
      render json: { success: false, message: "player's turnover increment failed" }, status: 400
    end
  end

  private

  def load_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name, :number)
  end
end
