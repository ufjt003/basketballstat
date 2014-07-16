class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :number, :team_name, :team_id

  def team_name
    object.team.try(:name)
  end

  def team_id
    object.team.try(:id)
  end

end
