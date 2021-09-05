class TournamentYearsController < ApplicationController

    def show
        # @tournament_days = Match.joins(:tournament_year).select("day::date").where(tournament_year: params[:id]).group("day::date").order("day::date desc")
        # @selected_tournament_day = params[:day] ? params[:day]  : @tournament_days.first.day
        # @tournament_year = TournamentYear.pre_loading_of_players_and_matches.find(params[:id]).where(matches: {day: @selected_tournament_day.in_time_zone.all_day})
        # @tournament_days_map = @tournament_days.map{ |tournament_day| [tournament_day.day.strftime('%Y/%m/%d'), tournament_day.day]}
        # @tournament_days_array = Match.joins(:tournament_year).select("day::date").where(tournament_year: params[:id]).group("day::date").order("day::date desc").map{ |tournament_day| [tournament_day.day.strftime('%Y/%m/%d'), tournament_day.day]}
        @tournament_days_array = Match.joins(:tournament_year).select("day::date").where(tournament_year: params[:id]).group("day::date").order("day::date desc").map do |tournament_day|
            [tournament_day.day.strftime('%Y/%m/%d'), tournament_day.day]
        end
        @selected_tournament_day = params[:day] ? params[:day]  : @tournament_days_array[0][1]
        @tournament_year = TournamentYear.eager_loading_of_matches.where(matches: {day: @selected_tournament_day.in_time_zone.all_day}).order("matches.day desc").find(params[:id])
    end
    
end
