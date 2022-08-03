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

  def period_for_show
    self.first_day.strftime("%Y/%m/%d") + " ~ " + self.last_day.strftime("%Y/%m/%d")
  end

  def hold_now_flag
    Time.zone.now.between?(self.first_day, self.last_day)
  end

  def get_days_and_formatted_days
    
    # できないっぽい
    # https://qiita.com/akinov/items/c826f34b1f326f0adf7a
    matches.select("to_char(matches.day, 'YYYY/MM/dd') as formatted_day, to_char(matches.day, 'YYYY/MM/dd') as formatted_key_day").group("to_char(matches.day, 'YYYY/MM/dd')")

    @tournament_days_and_formatted_days = {}
    matches.pluck(:day).map do |date|
      @tournament_days_and_formatted_days[date.strftime("%Y/%m/%d").to_sym] = date
    end
    return @tournament_days_and_formatted_days
  end
end
