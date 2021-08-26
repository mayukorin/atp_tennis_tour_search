class TournamentYearAndPlayerForMapSerializer < ActiveModel::Serializer
    belongs_to :player
    attributes :remain_flag
end