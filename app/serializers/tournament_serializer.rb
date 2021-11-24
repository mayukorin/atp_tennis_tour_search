class TournamentSerializer < ActiveModel::Serializer
    attributes :name, :abbreviation, :city, :atp_category
end