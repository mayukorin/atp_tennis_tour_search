class TournamentYearsController < ApplicationController

    def selected_tournament_year_show
        @selected_tournament_year_id = params[:selected_tournament_year_id]
        @tournament_year = TournamentYear.eager_loading.find(@selected_tournament_year_id)


        @tournament_days_collection = {}
        Match.joins(:tournament_year).where(tournament_year: @tournament_year.id).pluck(:day).map do |date|
            @tournament_days_collection[date.strftime("%Y/%m/%d")] = date
        end
        
        @tournament_days_collection = @tournament_days_collection.sort.reverse
        if @tournament_days_collection.length > 0
            @selected_tournament_day = @tournament_days_collection.first.second
            @selected_tournament_day_matches = Match.eager_loading.search_by_day_and_tournament_year(@selected_tournament_day.in_time_zone.all_day, @selected_tournament_year_id).order(day: :desc)
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
