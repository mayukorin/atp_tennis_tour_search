class TournamentYear < ApplicationRecord
  belongs_to :tournament
  has_one :batch_schedule
  belongs_to :player, optional: true
  has_many :tournament_year_and_players
  has_many :tournament_year_and_remain_players, ->{ where remain_flag: true }, class_name: 'TournamentYearAndPlayer'
  has_many :top_ten_remain_players, ->{order(ranking: :desc).limit(10)}, through: :tournament_year_and_remain_players, class_name: 'Player'
  has_many :matches, ->{order(day: :desc)}
  belongs_to :champion, class_name: 'Player', :foreign_key => 'champion_id', optional: true
  scope :eager_loading, -> { eager_load({ tournament: [:atp_category, :city ] }, :champion, {tournament_year_and_players: :player } ) }
  scope :top_ten_remain_players_loading, -> { preload({ tournament: [:atp_category, :city ] }, :champion,  :top_ten_remain_players) }
  scope :eager_loading2, -> { eager_load(:tournament_year_and_players) }
end
