class TournamentYearsController < ApplicationController

    def show
        @tournament_year = TournamentYear.pre_loading_of_players_and_matches.find(params[:id])
    end
    
end
