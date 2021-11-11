class AddColumnPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :ranking, :integer
  end
end
