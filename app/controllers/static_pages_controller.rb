class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @id_list = current_user.favorite_players_id_list
      player_matches_id_sql = PlayerMatch.select(:id).joins(:match).where('player_id = players.id').in_order_of_latest.limit(2).to_sql
      @favorite_players = Player.eager_loading.where("player_matches.id in (#{player_matches_id_sql})").find(@id_list)
    end
    
  end


  def get_tournament_info

    tournament_year_and_players_id_sql = TournamentYearAndPlayer.select(:id).where('tournament_year_id = tournament_years.id and remain_flag = TRUE').in_order_of_player_ranking.limit(10).to_sql
    tournament_this_years = TournamentYear.eager_loading.where("now_flag = TRUE and (tournament_year_and_players.id is NULL or tournament_year_and_players.id in (#{tournament_year_and_players_id_sql}))")
    render json: tournament_this_years, each_serializer: TournamentYearForMapSerializer, include: ['champion', 'tournament', 'tournament.atp_category', 'tournament_year_and_players', 'tournament_year_and_players.player']
  end

  def get_tournament_list
    tournaments = Tournament.where("name LIKE ?", params[:name]+"%")
    players = Player.where("name LIKE ?", params[:name]+"%")
    render json: { tournaments: tournaments, players: players }
  end
end
