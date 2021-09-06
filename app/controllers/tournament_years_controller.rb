class TournamentYearsController < ApplicationController

    def show
        @tournament_year = TournamentYear.eager_loading.find(params[:id])
        @tournament_days_array = Match.joins(:tournament_year).select("day::date").where(tournament_year: params[:id]).group("day::date").order("day::date desc").map do |tournament_day|
            [tournament_day.day.strftime('%Y/%m/%d'), tournament_day.day]
        end
        if @tournament_days_array.size() > 0
            @selected_tournament_day = params[:day] ? params[:day]  : @tournament_days_array[0][1]
            @selected_tournament_day_matches = Match.eager_loading.where(day: @selected_tournament_day.in_time_zone.all_day, tournament_year: params[:id]).order(day: :desc)
        end
    end
    
end
