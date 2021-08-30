class TournamentYearsController < ApplicationController

    def show
        @tournament_year = TournamentYear.preload(tournament_year_and_players: :player, matches: [:home_player, :away_player]).find(params[:id])
    end
    
end
