class TournamentYearForMapSerializer < ActiveModel::Serializer
  belongs_to :tournament
  # attributes :tournament_year_and_players
  belongs_to :champion, class_name: 'Player', :foreign_key => 'champion_id'
  has_many :tournament_year_and_players, each_serializer: TournamentYearAndPlayerSerializer 
'''
  def tournament_year_and_players
      object.tournament_year_and_players.joins(:player)
  end
  '''
end
