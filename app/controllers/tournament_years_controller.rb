class TournamentYearsController < ApplicationController

    def show
        @tournament_days = Match.joins(:tournament_year).select("day::date").where(tournament_year: params[:id]).group("day::date").order("day::date desc")
        @selected_tournament_day = params[:day] ? params[:day]  : @tournament_days.first.day
        # @tournament_year = TournamentYear.pre_loading_of_players_and_matches.find(params[:id]).where(matches: {day: @selected_tournament_day.in_time_zone.all_day})
        @tournament_days = @tournament_days.map{ |tournament_day| [tournament_day.day.strftime('%Y/%m/%d'), tournament_day.day]}
        @tournament_year = TournamentYear.eager_load(tournament_year_and_players: :player, matches: [:home_player, :away_player, :win_player, :tournament_year]).where(matches: {day: @selected_tournament_day.in_time_zone.all_day}).order("matches.day desc").find(params[:id])
    end
    
end
