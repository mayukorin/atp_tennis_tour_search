class TournamentYearsController < ApplicationController

    def show
       
        @selected_tournament_year_id = params[:selected_tournament_year_id]
        
        @tournament_year = TournamentYear.eager_loading.find(@selected_tournament_year_id)


        @tournament_days_collection = Match.select("to_char(day, 'YYYY/mm/dd') as day_str, day::date").joins(:tournament_year).where(tournament_year: params[:id]).group("to_char(day, 'YYYY/mm/dd'), day::date").order("day::date desc")
        if @tournament_days_collection.length > 0
            @selected_tournament_day = @tournament_days_collection.first[:day]
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
