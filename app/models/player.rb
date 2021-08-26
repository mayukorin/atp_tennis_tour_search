class Player < ApplicationRecord
    has_many :tournament_years
    has_many :tournament_year_and_players
    has_many :my_champion_tournament_years, class_name: 'TournamentYear', :foreign_key => 'champion_id'
    has_many :player_matches
    has_many :matches, ->{order(day: :desc)}, through: :player_matches
end
