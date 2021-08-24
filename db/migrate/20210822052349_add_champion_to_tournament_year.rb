class AddChampionToTournamentYear < ActiveRecord::Migration[6.1]
  def change
    add_reference :tournament_years, :champion, foreign_key: { to_table: :players}
  end
end
