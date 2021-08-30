class StaticPagesController < ApplicationController
  def home
    puts "ok"
    # puts Player.preload(:player_matches).all.to_sql
    @favorite_players = Player.preload(player_matches: :match).all
  end

  def get_tournament_info
    
    tournament_this_years = TournamentYear.where(now_flag: true)
    render json: tournament_this_years, each_serializer: TournamentYearForMapSerializer, include: ['champion', 'tournament', 'tournament_year_and_players', 'tournament_year_and_players.player']
    
  end
end
