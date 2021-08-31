class StaticPagesController < ApplicationController
  def home
    
    # @favorite_players = Player.preload(player_matches: {match: [:tournament_year, :home_player, :away_player]}).all
    # @favorite_players = Player.preload(newer_matches: [:tournament_year, :home_player, :away_player]).all
    # @favorite_players = Player.eager_load(:newer_matches, player_matches: {newer_match: [:tournament_year, :home_player, :away_player]}).all
    # @favorite_players = Player.eager_load(:matches).order("matches.day DESC").where("matches_count = ?", 2).all
    # @favorite_players = Player.eager_load(newer_matches: [:tournament_year, :home_player, :away_player]).all
    puts "OK"
    # puts Player.eager_load(newer_matches: [:tournament_year, :home_player, :away_player]).all.to_sql
    # これやっても，limitは反映されてないから，view側でplayerごとにlimitしてる
    # puts Player.eager_load(player_matches: {newer_match: [:tournament_year, :home_player, :away_player]}).all
    # これやると，全playerに紐づくnewer_match 全体で新しい順に 2 個しか持ってこない
    # puts Player.preload(newer_matches: [:tournament_year, :home_player, :away_player]).all.to_sql
    # @favorite_players =  Player.eager_load(:player_matches, :matches).where('matches.id < ?', 3)
    # @favorite_players =  Player.eager_load(:player_matches, :matches)

    # @favorite_players = Player.eager_load(player_matches: :match).where("player_matches.id in (select player_matches.id from player_matches left outer join matches on matches.id = match_id where player_id = players.id order by matches.day desc limit 2)");
    @favorite_players = Player.eager_load({matches: [{tournament_year: :tournament} , :home_player, :away_player]}, :player_matches).where("player_matches.id in (select player_matches.id from player_matches left outer join matches on matches.id = match_id where player_id = players.id order by matches.day desc limit 2)");
  end


  def get_tournament_info
    
    tournament_this_years = TournamentYear.where(now_flag: true)
    render json: tournament_this_years, each_serializer: TournamentYearForMapSerializer, include: ['champion', 'tournament', 'tournament_year_and_players', 'tournament_year_and_players.player']
    
  end
end
