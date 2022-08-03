class TournamentsController < ApplicationController
    def show
        @tournament = Tournament.find(params[:id])

        @tournament_year_ids_and_years = @tournament.get_tournament_year_ids_and_years
        @selected_tournament_year_id = @tournament_year_ids_and_years.first[:id]
        @tournament_year = TournamentYear.eager_loading.find(@selected_tournament_year_id)
        
        @tournament_days_and_formatted_days = @tournament_year.get_days_and_formatted_days
        puts @tournament_days_and_formatted_days
        if @tournament_days_and_formatted_days.length > 0
            @selected_tournament_day = @tournament_days_and_formatted_days.values.first
            # @selected_tournament_day = @tournament_days_and_formatted_days.first[:formatted_key_day]
            @selected_tournament_day_matches = Match.eager_loading.search_by_day_and_tournament_year(@selected_tournament_day.in_time_zone.all_day, @tournament_year.id).order(day: :desc)
        end
    end
end
