class AddPlayerIdToTournamentYear < ActiveRecord::Migration[6.1]
  def change
    add_reference :tournament_years, :player, foreign_key: true
  end
end
