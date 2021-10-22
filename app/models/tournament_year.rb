class TournamentYear < ApplicationRecord
  belongs_to :tournament
  has_one :batch_schedule
  belongs_to :player, optional: true
  has_many :tournament_year_and_players
  has_many :matches, ->{order(day: :desc)}
  belongs_to :champion, class_name: 'Player', :foreign_key => 'champion_id', optional: true
  scope :eager_loading, -> { eager_load({ tournament: :atp_category }, :champion, {tournament_year_and_players: :player}) }
  scope :eager_loading2, -> { eager_load(:tournament_year_and_players) }
end
