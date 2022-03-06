class PlayerMatchesController < ApplicationController

    def index
        @player = Player.find(params[:player_id])
        @selected_tournament_year_and_player = TournamentYearAndPlayer.find(params[:tournament_year_and_player_id] )
        @selected_tournament_year_player_matches = PlayerMatch.eager_loading
                                                    .search_by_tournament_year_and_player(@selected_tournament_year_and_player.tournament_year.id, @player.id)
                                                    .in_order_of_latest
        respond_to do |format|
            format.js
        end
    end
end
