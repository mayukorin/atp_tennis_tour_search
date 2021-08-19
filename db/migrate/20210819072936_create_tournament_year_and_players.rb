class CreateTournamentYearAndPlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :tournament_year_and_players do |t|
      t.boolean :win_flag
      t.references :player, null: false, foreign_key: true
      t.references :tournament_year, null: false, foreign_key: true

      t.timestamps
    end
  end
end
