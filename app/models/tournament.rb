class Tournament < ApplicationRecord
    has_many :tournament_years
    belongs_to :atp_category
    scope :eager_loading, -> { eager_load(:atp_category , tournament_years: [:champion, {tournament_year_and_players: :player}] ) }
end
