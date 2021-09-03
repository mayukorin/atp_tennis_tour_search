class TournamentYearsController < ApplicationController

    def show
        @tournament_year = TournamentYear.pre_loading_of_players_and_matches.find(params[:id])
        @dates = Match.select("date(day)").joins(:tournament_year).where(tournament_year: params[:id]).group("date(day)")
    end
    
end
