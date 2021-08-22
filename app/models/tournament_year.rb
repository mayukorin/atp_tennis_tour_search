class TournamentYear < ApplicationRecord
  belongs_to :tournament
  has_many :batch_schedules
  belongs_to :player, optional: true
  has_many :tournament_year_and_players
  has_many :matches
  belongs_to :champion, class_name: 'Player', :foreign_key => 'champion_id', optional: true
end
