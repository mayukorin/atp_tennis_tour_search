class TournamentsController < ApplicationController
    def show
        @tournament = Tournament.find(params[:id])
       
        @years_collection = TournamentYear.select("to_char(first_day, 'YYYY') as year, tournament_years.id").joins(:tournament).where(tournament: @tournament.id).order(first_day: :desc)
        @selected_tournament_year_id = @years_collection.first[:id]
        
        @tournament_year = TournamentYear.eager_loading.find(@selected_tournament_year_id)
        
        @tournament_days_collection = Match.select("to_char(day, 'YYYY/mm/dd') as day_str, day::date").joins(:tournament_year).where(tournament_year: @tournament_year.id).group("to_char(day, 'YYYY/mm/dd'), day::date").order("day::date desc")
        
        if @tournament_days_collection.length > 0
            @selected_tournament_day = @tournament_days_collection.first[:day]
            @selected_tournament_day_matches = Match.eager_loading.search_by_day_and_tournament_year(@selected_tournament_day.in_time_zone.all_day, @tournament_year.id).order(day: :desc)
        end
    end
end
