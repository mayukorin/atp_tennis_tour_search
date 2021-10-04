class PlayersController < ApplicationController
  def show

    @player = Player.find(params[:id])
    @tournament_years_array = TournamentYearAndPlayer.eager_loading.where(player: @player.id).order('tournament_years.first_day DESC').map do |typ|
      [typ.tournament_year.tournament.name + "(" + typ.tournament_year.first_day.strftime("%Y") + ")", typ.id]
    end
    @selected_tournament_year_and_player = TournamentYearAndPlayer.find(@tournament_years_array[0][1])
    @selected_tournament_year_player_matches = PlayerMatch.eager_loading
                                                .search_by_tournament_year_and_player(@selected_tournament_year_and_player.tournament_year.id, @player.id).in_order_of_latest
  end
end


