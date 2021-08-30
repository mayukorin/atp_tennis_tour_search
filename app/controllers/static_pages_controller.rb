class StaticPagesController < ApplicationController
  def home
    
    # @favorite_players = Player.preload(player_matches: {match: [:tournament_year, :home_player, :away_player]}).all
    @favorite_players = Player.preload(newer_matches: [:tournament_year, :home_player, :away_player]).all
    # @favorite_players = Player.eager_load(:matches).order("matches.day DESC").where("matches_count = ?", 2).all
    puts "OK"
    puts Player.eager_load(:player_matches, :matches).where('matches.count(*) < ?', 3).to_sql
    # @favorite_players =  Player.eager_load(:player_matches, :matches).where('matches.id < ?', 3)
    # @favorite_players =  Player.eager_load(:player_matches, :matches)
    
  end


  def get_tournament_info
    
    tournament_this_years = TournamentYear.where(now_flag: true)
    render json: tournament_this_years, each_serializer: TournamentYearForMapSerializer, include: ['champion', 'tournament', 'tournament_year_and_players', 'tournament_year_and_players.player']
    
  end
end
