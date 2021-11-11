class TournamentYearAndPlayer < ApplicationRecord
  belongs_to :player
  belongs_to :tournament_year
  scope :pre_loading, -> { preload({tournament_year: :tournament}) }
  scope :eager_loading, -> { eager_load({tournament_year: :tournament}) }
  scope :in_order_of_player_ranking, -> { order("players.ranking DESC")}
end
