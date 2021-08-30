class TournamentYearAndPlayer < ApplicationRecord
  belongs_to :player
  belongs_to :tournament_year
  has_many :tour_player_matches
  has_many :matches, through: :tour_player_matches
end
