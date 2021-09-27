class TournamentSerializer < ActiveModel::Serializer
    attributes :name, :abbreviation, :city
    has_many :tournament_years, serializer: TournamentYearForMapSerializer
end