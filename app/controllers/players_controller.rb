class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:id])
    @tournament_year_and_players = TournamentYearAndPlayer.preload({tournament_year: :tournament}, :tour_player_matches, {matches: [:tournament_year, :home_player, :away_player]}).where(player_id: @player.id)
  end
end
