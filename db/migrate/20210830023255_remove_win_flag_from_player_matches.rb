class RemoveWinFlagFromPlayerMatches < ActiveRecord::Migration[6.1]
  def change
    remove_column :player_matches, :win_flag, :boolean
  end
end
