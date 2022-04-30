class TournamentYearForMapSerializer < ActiveModel::Serializer
  belongs_to :tournament, serializer: TournamentSerializer
  belongs_to :champion, class_name: 'Player', :foreign_key => 'champion_id'
  # has_many :tournament_year_and_players, serializer: TournamentYearAndPlayerForMapSerializer
  has_many :top_ten_remain_players
  attributes :period_for_show, :id, :hold_now_flag
  
  def period_for_show
    object.period_for_show
  end

  def hold_now_flag
    object.hold_now_flag
  end
end
