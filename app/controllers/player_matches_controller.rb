class PlayerMatchesController < ApplicationController

    def index_by_player_and_tournament_year
        @selected_tournament_year_and_player = TournamentYearAndPlayer.find(params[:tournament_year_and_player_id] )
        @selected_tournament_year_player_matches = PlayerMatch.eager_loading
                                                    .search_by_player_and_tournament_year(params[:player_id], @selected_tournament_year_and_player.tournament_year.id)
                                                    .in_order_of_latest
        respond_to do |format|
            format.js
        end
    end
end
