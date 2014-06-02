class GameSerializer < ActiveModel::Serializer
  attributes :id, :gametime, :in_progress, :home_team, :away_team, :home_team_score, :away_team_score, :name, :is_finished

  def is_finished
    object.is_finished?
  end

  def in_progress
    object.is_in_progress?
  end

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
    object.try(:home_team_score)
  end

  def away_team_score
    object.try(:away_team_score)
  end

  def name
    object.try(:name)
  end
end
