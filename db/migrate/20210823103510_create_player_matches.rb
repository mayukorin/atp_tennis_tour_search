class CreatePlayerMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :player_matches do |t|
      t.boolean :win_flag
      t.references :player, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true

      t.timestamps
    end
  end
end
