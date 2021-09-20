class PlayerMatchesController < ApplicationController

    def index
        
        @selected_tournament_year_and_player = TournamentYearAndPlayer.find(params[:tournament_year_player] )
        @selected_tournament_year_player_matches = PlayerMatch.eager_loading.where(matches: {tournament_year: @selected_tournament_year_and_player.tournament_year.id}, player: @selected_tournament_year_and_player.player.id)
        respond_to do |format|
            format.js
        end
    end
end
