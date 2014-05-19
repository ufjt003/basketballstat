class GameSerializer < ActiveModel::Serializer
  attributes :id, :gametime, :in_progress, :home_team, :away_team, :home_team_score, :away_team_score

  def gametime
    object.gametime.strftime("%Y-%m-%d %H:%M:%S %z")
  end

  def home_team
    object.home_team.try(:name)
  end

  def away_team
    object.away_team.try(:name)
  end

  def home_team_score
    object.home_team.try(:game_score)
  end

  def away_team_score
    object.away_team.try(:game_score)
  end
end
