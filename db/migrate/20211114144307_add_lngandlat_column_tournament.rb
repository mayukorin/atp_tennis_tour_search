class AddLngandlatColumnTournament < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
