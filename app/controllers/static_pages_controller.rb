class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @id_list = current_user.favorite_players_id_list
      player_matches_id_sql = PlayerMatch.select(:id).joins(:match).where('player_id = players.id').order('matches.day desc').limit(2).to_sql
      @favorite_players = Player.eager_loading.where("player_matches.id in (#{player_matches_id_sql})").find(@id_list)
    end
    
  end


  def get_tournament_info

    

    
    
    

    tournament_year_and_players_id_sql = TournamentYearAndPlayer.select(:id).where('tournament_year_id = tournament_years.id').limit(10).to_sql
    tournament_this_years_id_sql = TournamentYear.select(:id).left_joins(:tournament, :tournament_year_and_players).where(
      "now_flag = TRUE and tournament_id = tournaments.id and (tournament_year_and_players is NULL or 
      tournament_year_and_players.id in (#{tournament_year_and_players_id_sql}))").to_sql




    tty = TournamentYear.left_joins(:tournament_year_and_players).where(
      "now_flag = TRUE and (tournament_year_and_players is NULL or 
      tournament_year_and_players.id in (#{tournament_year_and_players_id_sql}))")
    tty = TournamentYear.left_joins(:tournament_year_and_players).where("tournament_year_and_players is NULL or tournament_year_and_players.id in (#{tournament_year_and_players_id_sql})")
    puts "mmmmmmmmmmmmmm"
    puts tty.length
    
    # tournament_this_years_id_sql = TournamentYear.select(:id).left_joins(:tournament, :tournament_year_and_players).where(
      # "now_flag = TRUE and tournament_id = tournaments.id and tournament_year_and_players.id = 1").to_sql
    tournament_id_sql = Tournament.select(:id).joins(tournament_years: :tournament_year_and_players).where("tournament_years.id in (#{tournament_this_years_id_sql})").to_sql
    tournament_id_sql = Tournament.select(:id).joins(:tournament_years).where("tournament_years.id in (#{tournament_this_years_id_sql})").to_sql
    tt = Tournament.joins(:tournament_years).where("tournament_years.id in (#{tournament_this_years_id_sql})")
    puts "oooooooooo"
    puts tt.length
    puts "oooooooooo"
    atp_categories = AtpCategory.eager_loading.where("tournaments is NULL or tournaments.id in (#{tournament_id_sql})")

    atp_categories.each do |atp|
      puts atp.name
      unless atp.tournaments.length == 0
        atp.tournaments.each do |t|
          unless t.tournament_years.length == 0
            t.tournament_years.each do |ty|
              unless ty.tournament_year_and_players.length == 0
                puts ty.tournament_year_and_players.length
              end
            end
          end
        end
      end

    end
    
    render json: atp_categories, each_serializer: AtpCategorySerializer, include: ['tournaments', 'tournaments.tournament_years', 'tournaments.tournament_years.champion', 'tournaments.tournament_years.tournament_year_and_players', 'tournaments.tournament_years.tournament_year_and_players.player']
    # atp_categories = AtpCategory.eager_loading
    # render json: atp_categories, each_serializer: AtpCategorySerializer, include: ['tournaments']
  end

  def get_tournament_info2
    tournament_year_and_players_id_sql = TournamentYearAndPlayer.select(:id).where('tournament_year_id = tournament_years.id').limit(10).to_sql
    tournament_this_years_id_sql = TournamentYear.select(:id).joins(:tournament, :tournament_year_and_players).where(
      "now_flag = TRUE and tournament_id = tournaments.id and (tournament_year_and_players.id is NULL or 
      tournament_year_and_players.id in (#{tournament_year_and_players_id_sql}))")

    atp_categories = AtpCategory.eager_loading.where("tournament_years.id in (#{tournament_this_years_id_sql})")
    puts atp_categories
  end
end
