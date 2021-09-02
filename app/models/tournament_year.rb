class TournamentYear < ApplicationRecord
  belongs_to :tournament
  has_many :batch_schedules
  belongs_to :player, optional: true
  has_many :tournament_year_and_players
  has_many :matches, ->{order(day: :desc)}
  belongs_to :champion, class_name: 'Player', :foreign_key => 'champion_id', optional: true
  scope :eager_loading_of_players, -> { eager_load(:tournament, :champion, {tournament_year_and_players: :player}) }
  scope :pre_loading_of_players_and_matches, -> { preload(tournament_year_and_players: :player, matches: [:home_player, :away_player, :win_player, :tournament_year]) }
end
