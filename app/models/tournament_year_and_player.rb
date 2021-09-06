class TournamentYearAndPlayer < ApplicationRecord
  belongs_to :player
  belongs_to :tournament_year
  scope :pre_loading, -> { preload({tournament_year: :tournament}) }
  scope :eager_loading, -> { eager_load({tournament_year: :tournament}) }
end
