class StaticPagesController < ApplicationController
  def home
    @favorite_players = Player.all
  end

  def get_tournament_info
    
    tournament_this_years = TournamentYear.where(now_flag: true)
    render json: tournament_this_years, each_serializer: TournamentYearForMapSerializer, include: ['champion', 'tournament', 'tournament_year_and_players', 'tournament_year_and_players.player']
    
  end
end
