class CreateTournamentYearAndPlayerMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_player_matches do |t|
      t.references :match, foreign_key: true
      t.references :tournament_year_and_player, foreign_key: true
      t.timestamps
    end
  end
end
