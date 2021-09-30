class AddAtpCategoryIdToTournaments < ActiveRecord::Migration[6.1]
  def change
    add_reference :tournaments, :atp_category, foreign_key: true
  end
end
