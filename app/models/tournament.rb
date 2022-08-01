class Tournament < ApplicationRecord
    has_many :tournament_years
    belongs_to :atp_category
    belongs_to :city
    scope :eager_loading, -> { eager_load(:atp_category , tournament_years: [:champion, {tournament_year_and_players: :player}] ) }

    def get_tournament_year_ids_and_years
        tournament_years.select("to_char(first_day, 'YYYY') as year, tournament_years.id").order(first_day: :desc)
    end
end
