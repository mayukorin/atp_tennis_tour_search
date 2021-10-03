class PlayerMatch < ApplicationRecord
  belongs_to :player
  belongs_to :match
  scope :eager_loading, -> { eager_load(:player, match: [{tournament_year: :tournament}, :home_player, :away_player, :win_player]) }
  scope :in_order_of_latest, -> { order("matches.day desc") }
  scope :search_by_tournament_year_and_player, -> (tournament_year_id, player_id ) { where(matches: {tournament_year: tournament_year_id }, player: player_id ) }
end
