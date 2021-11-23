class AddCityIdToTournaments < ActiveRecord::Migration[6.1]
  def change
    add_reference :aities, :city, foreign_key: true
  end
end
