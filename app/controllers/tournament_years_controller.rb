class TournamentYearsController < ApplicationController

    def show
        @selected_tournament_year_id = params[:selected_tournament_year_id]
        @tournament_year = TournamentYear.eager_loading.find(@selected_tournament_year_id)

        @tournament_days_and_formatted_days = @tournament_year.get_days_and_formatted_days
        if @tournament_days_and_formatted_days.length > 0
            @selected_tournament_day = @tournament_days_and_formatted_days.values.first
            @selected_tournament_day_matches = Match.eager_loading.search_by_day_and_tournament_year(@selected_tournament_day.in_time_zone.all_day, @tournament_year.id).order(day: :desc)
        end

        respond_to do |format|
            format.js
        end
    end
end
