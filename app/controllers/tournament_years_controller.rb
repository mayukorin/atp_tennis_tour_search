class TournamentYearsController < ApplicationController

    def show
        '''
        @selected_tournament_day = params[:day]
        @selected_tournament_day_matches = Match.eager_loading.search_by_day_and_tournament_year(@selected_tournament_day.in_time_zone.all_day, params[:id]).order(day: :desc)
        respond_to do |format|
            format.js
        end
        '''
        @selected_tournament_year_id = params[:selected_tournament_year_id]
        
        @tournament_year = TournamentYear.eager_loading.find(@selected_tournament_year_id)
        @tournament_days_array = Match.joins(:tournament_year).select("day::date").where(tournament_year: params[:id]).group("day::date").order("day::date desc").map do |tournament_day|
            [tournament_day.day.strftime('%Y/%m/%d'), tournament_day.day]
        end
        if @tournament_days_array.size() > 0
            @selected_tournament_day = @tournament_days_array[0][1]
            @selected_tournament_day_matches = Match.eager_loading.search_by_day_and_tournament_year(@selected_tournament_day.in_time_zone.all_day, params[:id]).order(day: :desc)
        end
        respond_to do |format|
            format.js
        end
    end

    def day_show
        @selected_tournament_day = params[:day]
        @selected_tournament_day_matches = Match.eager_loading.search_by_day_and_tournament_year(@selected_tournament_day.in_time_zone.all_day, params[:id]).order(day: :desc)
        respond_to do |format|
            format.js
        end
    end
end
