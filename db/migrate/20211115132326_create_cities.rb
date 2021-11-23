class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :aities do |t|
      t.string :name
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
