class Match < ApplicationRecord
  belongs_to :tournament_year
  has_many :player_matches
  has_many :players, through: :player_matches
end
