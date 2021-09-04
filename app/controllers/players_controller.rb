class PlayersController < ApplicationController
  def show
    '''
    @player = Player.find(params[:id])
    @tournament_year_and_players = TournamentYearAndPlayer.pre_loading.where(player_id: @player.id)
    @selected_tournament_year_id = params[:tournament] ? params[:tournament]  : @tournament_year_and_players.first.id
    @tournament_years = @tournament_year_and_players.map{ |tournament_year_and_player| [tournament_year_and_player.tournament_year.tournament.name + "(" + tournament_year_and_player.tournament_year.first_day.strftime("%Y") + ")", tournament_year_and_player.id]}
    # puts  @tournament_year_and_players.first.tournament_year.tournament.name
    @tournament_year_and_player = TournamentYearAndPlayer.pre_loading.where(player_id: @player.id, tournament_year_id: @selected_tournament_year_id)
    puts @tournament_year_and_player.id
    '''
    @player = Player.find(params[:id])
    @tournament_year_and_players = TournamentYearAndPlayer.pre_loading.where(player_id: @player.id)
    @selected_tournament_year_id = params[:tournament] ? params[:tournament]  : @tournament_year_and_players.first.tournament_year.id
    @tournament_years = @tournament_year_and_players.map{ |tournament_year_and_player| [tournament_year_and_player.tournament_year.tournament.name + "(" + tournament_year_and_player.tournament_year.first_day.strftime("%Y") + ")", tournament_year_and_player.tournament_year.id]}
    puts  @tournament_year_and_players.first.tournament_year.tournament.name
    puts @selected_tournament_year_id
    @tournament_year_and_player = TournamentYearAndPlayer.pre_loading.find_by(player_id: @player.id, tournament_year_id: @selected_tournament_year_id)
    # puts @tournament_year_and_player.id
  end
end
