class PlayersController < ApplicationController
  def show
 
    @player = Player.find(params[:id])
    @tournament_years_array = TournamentYearAndPlayer.eager_loading.where(player_id: @player.id).order('tournament_years.first_day DESC').map do |typ|
      [typ.tournament_year.tournament.name + "(" + typ.tournament_year.first_day.strftime("%Y") + ")", typ.id]
    end
    @selected_tournament_year_and_player = TournamentYearAndPlayer.find(@tournament_years_array[0][1])
    @selected_tournament_year_player_matches = PlayerMatch.eager_loading.where(matches: {tournament_year: @selected_tournament_year_and_player.tournament_year.id}, player: @player.id).order('matches.day DESC')
  end
end


