class TournamentYearForMapSerializer < ActiveModel::Serializer
  belongs_to :tournament, serializer: TournamentSerializer
  belongs_to :champion, class_name: 'Player', :foreign_key => 'champion_id'
  has_many :tournament_year_and_players, serializer: TournamentYearAndPlayerForMapSerializer
  attributes :period, :id, :hold_flag
  
  def period
    object.first_day.strftime("%m/%d") + " ~ " + object.last_day.strftime("%m/%d")
  end

  def hold_flag
    Time.zone.now.between?(object.first_day, object.last_day)
  end
end
