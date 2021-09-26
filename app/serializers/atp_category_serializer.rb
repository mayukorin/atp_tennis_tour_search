class AtpCategorySerializer < ActiveModel::Serializer
    attributes :name
    has_many :tournaments, serializer: TournamentSerializer
end