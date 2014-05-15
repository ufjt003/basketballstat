class GameSerializer < ActiveModel::Serializer
  attributes :gametime, :in_progress, :score
end
