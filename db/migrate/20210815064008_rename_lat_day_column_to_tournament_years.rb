class RenameLatDayColumnToTournamentYears < ActiveRecord::Migration[6.1]
  def change
    rename_column :tournament_years, :lat_day, :last_day
  end
end
