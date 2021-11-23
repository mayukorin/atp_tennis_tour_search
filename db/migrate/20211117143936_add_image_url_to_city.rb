class AddImageUrlToCity < ActiveRecord::Migration[6.1]
  def change
    add_column :cities, :image_url, :string
  end
end
