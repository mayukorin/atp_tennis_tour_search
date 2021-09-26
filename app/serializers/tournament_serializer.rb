class TournamentSerializer < ActiveModel::Serializer
    has_many :tournaments, serializer: TournamentSerializer
end