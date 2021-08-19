class Player < ApplicationRecord
    has_many :tournament_years
    has_many :tournament_year_and_players
end
