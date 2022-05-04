class MatchesController < ApplicationController

    def index_by_tournament_year_and_day
        @selected_tournament_day_matches = Match.eager_loading.search_by_day_and_tournament_year(params[:selected_tournament_day].in_time_zone.all_day, params[:selected_tournament_year_id]).order(day: :desc)
        respond_to do |format|
            format.js
        end
    end
end
