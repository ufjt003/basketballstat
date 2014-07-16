class GamePlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :number, :team_name, :playing_in_game, :team_id

  def team_name
    object.team.try(:name)
  end

  def team_id
    object.team.try(:id)
  end

  def playing_in_game
    GamePlayer.find_by(game_id: object.game_id, player_id: object.id).try(:in_game)
  end
end
