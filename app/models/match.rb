class Match < ApplicationRecord
  belongs_to :tournament_year
  has_many :player_matches
  has_many :players, through: :player_matches
  belongs_to :home_player, class_name: 'Player', :foreign_key => 'home_player_id'
  belongs_to :away_player, class_name: 'Player', :foreign_key => 'away_player_id'
  belongs_to :win_player, class_name: 'Player', :foreign_key => 'win_player_id', optional: true
  has_many :tour_player_matches
  has_many :tournament_year_and_players, through: :tour_player_matches 
  scope :eager_loading, -> { eager_load(:home_player, :away_player, :win_player, tournament_year: :tournament) } 
  scope :search_by_day_and_tournament_year, -> (all_day, tournament_year_id) { where(day: all_day, tournament_year: tournament_year_id) }


end
