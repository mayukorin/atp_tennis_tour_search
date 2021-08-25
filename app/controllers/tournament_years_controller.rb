class TournamentYearsController < ApplicationController

    def show
        @tournament_year = TournamentYear.find(params[:id])
    end
    
end
