class PlayerMatch < ApplicationRecord
  belongs_to :player
  belongs_to :match
  belongs_to :recently_match, class_name: 'Match', :foreign_key => 'match_id'
  scope :eager_loading, -> { eager_load(:player, match: [{tournament_year: :tournament}, :home_player, :away_player, :win_player]) }
  scope :in_order_of_latest, -> { order("matches.day desc") }
  scope :search_by_player_and_tournament_year, -> (player_id, tournament_year_id ) { where(player: player_id, matches: {tournament_year: tournament_year_id }) }
end
