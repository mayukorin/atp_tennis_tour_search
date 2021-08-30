class TournamentYearAndPlayerMatch < ApplicationRecord
    belongs_to :tournament_year_and_player
    belongs_to :match
end
