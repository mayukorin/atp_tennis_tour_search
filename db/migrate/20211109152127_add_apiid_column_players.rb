class AddApiidColumnPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :api_id, :integer, null: true
  end
end
