class PlayersController < ApplicationController
  def show

    @player = Player.find(params[:id])
    @tournament_years_array = []
    TournamentYearAndPlayer.eager_loading.where(player: @player.id).order('tournament_years.first_day DESC').each do |typ|
      tournament_name_and_year_hash = Hash.new
      tournament_name_and_year_hash[:tournament_name_and_year] = typ.tournament_year.tournament.name + "(" + typ.tournament_year.first_day.strftime("%Y") + ")"
      tournament_name_and_year_hash[:tournament_year_and_player_id] = typ.id
      tournament_name_and_year_hash = Struct.new(*(tournament_name_and_year_hash.keys)).new(*(tournament_name_and_year_hash.values))
      @tournament_years_array.push(tournament_name_and_year_hash)
    end
    
    if @tournament_years_array.length > 0
      @selected_tournament_year_and_player = TournamentYearAndPlayer.find(@tournament_years_array[0][:tournament_year_and_player_id])
      @selected_tournament_year_player_matches = PlayerMatch.eager_loading
                                                  .search_by_tournament_year_and_player(@selected_tournament_year_and_player.tournament_year.id, @player.id).in_order_of_latest
    end
  end
end


