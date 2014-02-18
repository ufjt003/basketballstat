class PlayersController < ApplicationController
  skip_authorization_check

  before_filter :load_player, only: [ :show ]

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

  private

  def load_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name, :number)
  end
end
