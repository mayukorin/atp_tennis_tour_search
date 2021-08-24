class RemovePlayerFromTournamentYear < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :tournament_years, column: :player_id
    remove_column :tournament_years, :player_id, :integer
  end
end
