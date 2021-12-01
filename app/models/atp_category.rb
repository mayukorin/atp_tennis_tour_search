class AtpCategory < ApplicationRecord
    has_many :tournaments
    scope :eager_loading, -> { eager_load(tournaments: {tournament_years: {tournament_year_and_players: :player}}) }
end
