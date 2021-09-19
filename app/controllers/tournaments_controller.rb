class TournamentsController < ApplicationController
    def show
        @years_array = TournamentYear.joins(:tournament).where(tournament: params[:id]).order(first_day: :desc).map do |tournament_year|
            [tournament_year.first_day.strftime('%Y'), tournament_year.id]
        end
        puts "oooooooo"
        puts params[:selected_tournament_year_id]
        @selected_tournament_year_id = params[:selected_tournament_year_id] ? params[:selected_tournament_year_id] : @years_array[0][1]
        # @tournament_year = TournamentYear.eager_loading.find(params[:id])
        @tournament_year = TournamentYear.eager_loading.find(@selected_tournament_year_id)
        @tournament_days_array = Match.joins(:tournament_year).select("day::date").where(tournament_year: params[:id]).group("day::date").order("day::date desc").map do |tournament_day|
            [tournament_day.day.strftime('%Y/%m/%d'), tournament_day.day]
        end
        if @tournament_days_array.size() > 0
            @selected_tournament_day = params[:day] ? params[:day]  : @tournament_days_array[0][1]
            @selected_tournament_day_matches = Match.eager_loading.where(day: @selected_tournament_day.in_time_zone.all_day, tournament_year: params[:id]).order(day: :desc)
        end
    end
end
