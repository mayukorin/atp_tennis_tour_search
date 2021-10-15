class AddColumnTournaments < ActiveRecord::Migration[6.1]
  def change
    add_column :tournaments, :site_url, :string
  end
end
