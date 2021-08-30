class DeleteTournamentYearAndPlayerMatches < ActiveRecord::Migration[6.1]
  def change
    drop_table :tour_player_matches
  end
end
