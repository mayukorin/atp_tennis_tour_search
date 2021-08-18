class TournamentYear < ApplicationRecord
  belongs_to :tournament
  has_many :batch_schedules
  belongs_to :player
end
