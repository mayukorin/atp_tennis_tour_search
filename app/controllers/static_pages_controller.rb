class StaticPagesController < ApplicationController
  def home
    @msg = "worldd"
  end

  def get_tournament_info
    tournaments_info = {}
    tournaments = TournamentYear.where(now_flag: true)
    tournaments.each do |tournamentYear|
      tournament_info = {}
      # puts tournamentYear.tournament.name
      if tournamentYear.player.nil? then
        tournament_info["now_flag"] = 1
      else 
        tournament_info["now_flag"] = 0
        tournament_info["champion"] = tournamentYear.player.name
      end
      tournament_info["name"] = tournamentYear.tournament.name + "(" + tournamentYear.first_day.strftime("%Y") + ")"
      tournament_info["city"] = tournamentYear.tournament.city
      puts tournamentYear.first_day.class
      tournament_info["period"] = tournamentYear.first_day.strftime("%m/%d") + " ~ " + tournamentYear.last_day.strftime("%m/%d")
  
      # ほんとは条件分岐
      if tournament_info["now_flag"] == 1 then
        tournament_year_and_players = TournamentYearAndPlayer.where(tournament_year: tournamentYear)
        main_players_info = {}
        tournament_year_and_players.each do |tournament_year_and_play|
          main_player_info = {}
          main_player_info["name"] = tournament_year_and_play.player.name
          main_player_info["win_flag"] = tournament_year_and_play.win_flag ? 1: 0
          main_players_info[tournament_year_and_play.id] = main_player_info
        end
        tournament_info["main_players"] = main_players_info
      end
      tournaments_info[tournamentYear.tournament.abbreviation] = tournament_info
    end
    puts "okkk"
    puts tournaments_info
    render json: tournaments_info
  end
end
