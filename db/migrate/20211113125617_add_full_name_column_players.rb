class AddFullNameColumnPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :full_name, :string
  end
end
