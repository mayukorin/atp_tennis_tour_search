class TournamentYearsController < ApplicationController

    def show
        @selected_tournament_day = params[:day]
        @selected_tournament_day_matches = Match.eager_loading.search_by_day_and_tournament_year(@selected_tournament_day.in_time_zone.all_day, params[:id]).order(day: :desc)
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
