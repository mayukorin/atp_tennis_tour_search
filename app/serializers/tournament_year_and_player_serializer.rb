class TournamentYearAndPlayerSerializer < ActiveModel::Serializer
    belongs_to :player
    attributes :win_flag
end