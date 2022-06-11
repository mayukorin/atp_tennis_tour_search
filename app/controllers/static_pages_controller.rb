class StaticPagesController < ApplicationController
  def home
    if logged_in?
      '''
      @id_list = current_user.favorite_players_id_list
      player_matches_id_sql = PlayerMatch.select(:id).joins(:match).where("player_id = players.id").in_order_of_latest.limit(2).to_sql
      favorite_player_recently_matches = current_user.favorite_players.eager_load(:recently_matches)
      puts favorite_player_recently_matches
      # puts player_matches_id_sql
      # @favorite_players = Player.eager_loading.where("player_matches.id in (#{player_matches_id_sql})").find(@id_list)
      # player_matches_id_sql = " SELECT player_matches.id FROM player_matches INNER JOIN matches ON matches.id = player_matches.match_id WHERE (player_id = players.id) ORDER BY matches.day desc LIMIT 2"
      @favorite_players_and_recently_matches = current_user.favorite_players.eager_loading.where("player_matches.id in (#{player_matches_id_sql})")
      # @favorite_players_and_recently_matches = current_user.favorite_players.recently_matches_loading
      # @favorite_players_and_recently_matches = current_user.favorite_players
      '''
      

      @player_ids_and_latest_match_days = PlayerMatch.joins(:match).select("player_id, max(matches.day) as md").group(:player_id).to_sql
      @latest_player_matches_and_matches_ids =  PlayerMatch.select("player_matches.id, player_matches.match_id").joins("INNER JOIN matches as bb ON player_matches.match_id=bb.id").joins("INNER JOIN (#{@player_ids_and_latest_match_days}) as aa ON player_matches.player_id=aa.player_id").where("aa.md = bb.day")
      @player_ids_and_second_latest_match_days = PlayerMatch.joins(:match).select("player_id, max(matches.day) as md").where("matches.id not in (?)", @latest_player_matches_and_matches_ids.pluck("player_matches.match_id")).group(:player_id).to_sql
      @second_latest_player_matches_ids =  PlayerMatch.joins("INNER JOIN matches as bb ON player_matches.match_id=bb.id").joins("INNER JOIN (#{@player_ids_and_second_latest_match_days}) as aa ON player_matches.player_id=aa.player_id").where("aa.md = bb.day").pluck("player_matches.id")
      @favorite_players_and_recently_matches = current_user.favorite_players.eager_loading.where("player_matches.id in (?)", @latest_player_matches_and_matches_ids.pluck("player_matches.id")+@second_latest_player_matches_ids)
      
      
      
      
      '''
      @bbbb.each do |b| 
        puts b.player_id
        puts b.md
      end
      @favorite_players_and_recently_matches = current_user.favorite_players.eager_loading.where("matches.id in (?)", @latest_matches_ids)
      @id_list = current_user.favorite_players_id_list
      @latest_matches_idss =  PlayerMatch.joins("INNER JOIN matches as bb ON player_matches.match_id=bb.id").joins("INNER JOIN (#{@aaa}) as aa ON player_matches.player_id=aa.player_id").where("aa.md = bb.day").pluck("bb.id, aa.md")
      puts "aaaaaaaaaaaaaaaaaaaaa"
      puts @latest_matches_idss
      # @aaa = PlayerMatch.joins(:match).select("player_id, max(matches.day) as md").group(:player_id).pluck("max(matches.day), player_id")
      # puts @aaa
      @latest_player_matches_idssss =  PlayerMatch.select("player_matches.id, player_matches.match_id").joins("INNER JOIN matches as bb ON player_matches.match_id=bb.id").joins("INNER JOIN (#{@aaa}) as aa ON player_matches.player_id=aa.player_id").where("aa.md = bb.day")
      puts @latest_player_matches_idssss
      puts @latest_player_matches_idssss.pluck("player_matches.id")
      puts "bbbbbbbbbbddddddd"
      '''
    end
    @favorite_players_and_recently_matches
  end


  def get_tournament_info

    # tournament_year_and_players_id_sql = TournamentYearAndPlayer.select(:id).where('tournament_year_id = tournament_years.id and remain_flag = TRUE').in_order_of_player_ranking.limit(10).to_sql
    # tournament_this_years = TournamentYear.eager_loading.where("now_flag = TRUE and (tournament_year_and_players.id is NULL or tournament_year_and_players.id in (#{tournament_year_and_players_id_sql}))")
    now_tournament_years = TournamentYear.where(now_flag: true).top_ten_remain_players_loading
    # now_tournament_years = TournamentYear.where(now_flag: true)
    # render json: tournament_this_years, each_serializer: TournamentYearForMapSerializer
    render json: now_tournament_years, each_serializer: TournamentYearForMapSerializer
  end

end
