class TeamStatSerializer < ActiveModel::Serializer
  attributes :two_pointer_attempt, :two_pointer_make, :three_pointer_attempt, :three_pointer_make,
             :free_throw_attempt, :free_throw_make, :assist, :rebound, :steal, :block, :turnover, :foul,
             :name, :team_id, :game_id

  def name
    object.team.name
  end

  def team_id
    object.team.id
  end

  def game_id
    object.game_id
  end
end
