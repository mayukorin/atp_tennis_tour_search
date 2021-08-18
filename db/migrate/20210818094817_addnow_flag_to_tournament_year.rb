class AddnowFlagToTournamentYear < ActiveRecord::Migration[6.1]
  def change
    add_column("tournament_years", "now_flag", :boolean)
  end
end
