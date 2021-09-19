class TournamentYearsController < ApplicationController

    def show
        @selected_tournament_day = params[:day]
        @selected_tournament_day_matches = Match.eager_loading.where(day: @selected_tournament_day.in_time_zone.all_day, tournament_year: params[:id]).order(day: :desc)
        respond_to do |format|
            format.html { redirect_to @tournament }
            format.js
        end
    end
end
