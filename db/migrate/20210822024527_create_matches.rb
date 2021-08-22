class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.date :day
      t.references :tournament_year, null: false, foreign_key: true
      t.references :player1, foreign_key: { to_table: :players}
      t.references :player2, foreign_key: { to_table: :players}
      t.references :win_player, foreign_key: { to_table: :players}
      t.timestamps
    end
  end
end
