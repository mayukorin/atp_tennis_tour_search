class Player < ApplicationRecord
    has_many :tournament_years
    has_many :tournament_year_and_players
    has_many :player1_mathes, class_name: 'Match', :foreign_key => 'player1_id'
    has_many :player2_mathes, class_name: 'Match', :foreign_key => 'player2_id'
    has_many :win_mathes, class_name: 'Match', :foreign_key => 'win_player_id'
    has_many :my_champion_tournament_years, class_name: 'TournamentYear', :foreign_key => 'champion_id'
end
