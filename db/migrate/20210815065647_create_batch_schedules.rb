class CreateBatchSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :batch_schedules do |t|
      t.date :today
      t.references :tournament_year, null: false, foreign_key: true

      t.timestamps
    end
  end
end
