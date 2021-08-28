class AddColumnTournamentYears < ActiveRecord::Migration[6.1]
  def change
    add_column :tournament_years, :api_id, :integer
  end
end
