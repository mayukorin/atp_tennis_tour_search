class PlayersController < ApplicationController
  def show
 
    @player = Player.find(params[:id])
   
    @tournament_years_array = TournamentYearAndPlayer.eager_loading.where(player_id: @player.id).order('tournament_years.first_day DESC').map do |typ|
      [typ.tournament_year.tournament.name + "(" + typ.tournament_year.first_day.strftime("%Y") + ")", typ.tournament_year.id]
    end
    @selected_tournament_year_id = params[:tournament] ? params[:tournament]  : @tournament_years_array[0][1]
    @player_matches = PlayerMatch.eager_loading.where(matches: {tournament_year: @selected_tournament_year_id}, player: @player.id)
    
  end
end
