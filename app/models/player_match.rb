class PlayerMatch < ApplicationRecord
  belongs_to :player
  belongs_to :match
  scope :eager_loading, -> { eager_load(:player, match: [{tournament_year: :tournament}, :home_player, :away_player, :win_player]) }
end
