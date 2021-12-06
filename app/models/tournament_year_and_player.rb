class TournamentYearAndPlayer < ApplicationRecord
  belongs_to :player
  belongs_to :tournament_year
  belongs_to :top_ten_remain_player, class_name: 'Player', :foreign_key => 'player_id'
  scope :pre_loading, -> { preload({tournament_year: :tournament}) }
  scope :eager_loading, -> { eager_load({tournament_year: :tournament}) }

  def tournament_name_and_year
    return tournament_year.tournament.name + "(" + tournament_year.first_day.strftime("%Y") + ")"
  end
end
