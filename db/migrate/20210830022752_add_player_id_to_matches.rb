class AddPlayerIdToMatches < ActiveRecord::Migration[6.1]
  def change
    add_reference :matches, :home_player, foreign_key: { to_table: :players}
    add_reference :matches, :away_player, foreign_key: { to_table: :players}
    add_reference :matches, :win_player, foreign_key: { to_table: :players}
    add_reference :matches, :tournament_year_and_player, foreign_key: true
  end
end
