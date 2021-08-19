class TournamentYear < ApplicationRecord
  belongs_to :tournament
  has_many :batch_schedules
  belongs_to :player, optional: true
  has_many :tournament_year_and_players
end
