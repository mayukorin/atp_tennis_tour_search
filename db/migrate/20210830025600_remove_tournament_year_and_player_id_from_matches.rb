class RemoveTournamentYearAndPlayerIdFromMatches < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :matches, column: :tournament_year_and_player_id
    remove_column :matches, :tournament_year_and_player_id, :integer
  end
end
