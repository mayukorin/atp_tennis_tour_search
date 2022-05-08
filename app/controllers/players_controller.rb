class PlayersController < ApplicationController
  def show

    @player = Player.find(params[:id])
    @tournament_year_and_players_collection = TournamentYearAndPlayer.eager_loading.where(player: @player.id).order('tournament_years.first_day DESC')
    
    if @tournament_year_and_players_collection.length > 0
      @selected_tournament_year_and_player = TournamentYearAndPlayer.find(@tournament_year_and_players_collection.first.id)
      @selected_tournament_year_and_player_matches = PlayerMatch.eager_loading
                                                  .search_by_player_and_tournament_year(@player.id, @selected_tournament_year_and_player.tournament_year.id).in_order_of_latest
    end
  end
end


