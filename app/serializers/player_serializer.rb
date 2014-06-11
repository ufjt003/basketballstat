class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :number, :team_name

  def team_name
    object.team.try(:name)
  end

end
