class AddCityToTournament < ActiveRecord::Migration[6.1]
  def change
    add_column :tournaments, :city, :string
  end
end
