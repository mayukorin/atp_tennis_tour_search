class RemovePlayer1FromMatches < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :matches, column: :player1_id
    remove_foreign_key :matches, column: :player2_id
    remove_foreign_key :matches, column: :win_player_id

    remove_column :matches, :player1_id, :integer
    remove_column :matches, :player2_id, :integer
    remove_column :matches, :win_player_id, :integer
  end
end
