class TournamentYearAndPlayer < ApplicationRecord
  belongs_to :player
  belongs_to :tournament_year
  has_many :tour_player_matches
  has_many :matches, ->{order(day: :desc)}, through: :tour_player_matches
  scope :pre_loading, -> { preload({tournament_year: :tournament}, :tour_player_matches, {matches: [:tournament_year, :home_player, :away_player, :win_player]}) }
end
