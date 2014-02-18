class PlayersController < ApplicationController
  skip_authorization_check

  def create
    if Player.create(params[:player])
      render json: { success: true, message: 'player created' }
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :number)
  end
end
