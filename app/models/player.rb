class Player < ApplicationRecord
    has_many :tournament_year_and_players
    has_many :my_champion_tournament_years, class_name: 'TournamentYear', :foreign_key => 'champion_id'
    has_many :player_matches
    has_many :matches, ->{order(day: :desc)}, through: :player_matches
    has_many :newer_matches, ->{order(day: :desc).limit(2)}, through: :player_matches, class_name: 'Match'
    has_many :home_matches, class_name: 'Match', :foreign_key => 'home_player_id'
    has_many :away_matches, class_name: 'Match', :foreign_key => 'away_player_id'
    has_many :win_matches, class_name: 'Match', :foreign_key => 'win_player_id'
end
