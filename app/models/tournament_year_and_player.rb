class TournamentYearAndPlayer < ApplicationRecord
  belongs_to :player
  belongs_to :tournament_year
end
