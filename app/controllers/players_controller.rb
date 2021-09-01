class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:id])
    @tournament_year_and_players = TournamentYearAndPlayer.pre_loading.where(player_id: @player.id)
  end
end
