class TournamentYearsController < ApplicationController

    def show
        @selected_tournament_year_id = params[:selected_tournament_year_id]
        @tournament_year = TournamentYear.eager_loading.find(@selected_tournament_year_id)


        @tournament_days_collection = {}
        Match.where(tournament_year: @tournament_year.id).order(day: :desc).pluck(:day).map do |date|
            @tournament_days_collection[date.strftime("%Y/%m/%d").to_sym] = date
        end
        
        if @tournament_days_collection.length > 0
            @selected_tournament_day = @tournament_days_collection.values.first
            @selected_tournament_day_matches = Match.eager_loading.search_by_day_and_tournament_year(@selected_tournament_day.in_time_zone.all_day, @selected_tournament_year_id).order(day: :desc)
        end

        respond_to do |format|
            format.js
        end
    end
end
