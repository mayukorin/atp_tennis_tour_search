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
    puts "1"
    # @tournament_year_and_players = TournamentYearAndPlayer.eager_load({tournament_year: :tournament}, :tour_player_matches, {matches: [:tournament_year, :home_player, :away_player, :win_player]}).where(player_id: player_id).order('tournament_years.first_day DESC')
    puts "11"
    puts "2"
    # @tournament_years_array = TournamentYearAndPlayer.eager_loading.where(player_id: @player.id).order('tournament_years.first_day DESC').map{ |tournament_year_and_player| [tournament_year_and_player.tournament_year.tournament.name + "(" + tournament_year_and_player.tournament_year.first_day.strftime("%Y") + ")", tournament_year_and_player.tournament_year.id]}
    @tournament_years_array = TournamentYearAndPlayer.eager_loading.where(player_id: @player.id).order('tournament_years.first_day DESC').map do |typ|
      [typ.tournament_year.tournament.name + "(" + typ.tournament_year.first_day.strftime("%Y") + ")", typ.tournament_year.id]
    end
  
    #@tournament_year_and_player = TournamentYearAndPlayer.eager_load({tournament_year: :tournament}, :tour_player_matches, {matches: [:tournament_year, :home_player, :away_player, :win_player]}).find_by(player_id: @player.id, tournament_year_id: @selected_tournament_year_id)
    puts "aaaaaaaaaaaab"
    # @selected_tournament_year_id = params[:tournament] ? params[:tournament]  : @tournament_year_and_players.first.tournament_year.id
    @selected_tournament_year_id = params[:tournament] ? params[:tournament]  : @tournament_years_array[0][1]
    # @tournament_year_and_player = @tournament_year_and_players.find_by(tournament_year_id: @selected_tournament_year_id)
    puts "3"
    @player_matches = PlayerMatch.eager_loading.where(matches: {tournament_year: @selected_tournament_year_id}, player: @player.id)
    puts "abddddddddddddddd"
    # puts @tournament_year_and_player.id
  end
end
