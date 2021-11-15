class AddCityIdToTournaments < ActiveRecord::Migration[6.1]
  def change
    add_reference :tournaments, :city, foreign_key: true
  end
end
