class RenameWinFlagColumnToTournamentYearAndPlayers < ActiveRecord::Migration[6.1]
  def change
    rename_column :tournament_year_and_players, :win_flag, :remain_flag
  end
end
