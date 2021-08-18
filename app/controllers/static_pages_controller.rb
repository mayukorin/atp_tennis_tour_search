class StaticPagesController < ApplicationController
  def home
    @msg = "worldd"
  end

  def get_tournament_info
    tournaments_info = {}
    tournaments = TournamentYear.where(now_flag: true)
    tournaments.each do |tournamentYear|
      tournament_info = {}
      tournament_info["now_flag"] = 0
      tournament_info["name"] = tournamentYear.tournament.name + "(" + tournamentYear.first_day.strftime("%Y") + ")"
      tournament_info["city"] = tournamentYear.tournament.city
      puts tournamentYear.first_day.class
      tournament_info["period"] = tournamentYear.first_day.strftime("%m/%d") + " ~ " + tournamentYear.last_day.strftime("%m/%d")
      tournament_info["champion"] = tournamentYear.player.name
      tournaments_info[tournamentYear.tournament.abbreviation] = tournament_info
    end
    render json: tournaments_info
  end
end
