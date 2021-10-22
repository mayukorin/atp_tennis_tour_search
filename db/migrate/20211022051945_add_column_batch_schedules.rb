class AddColumnBatchSchedules < ActiveRecord::Migration[6.1]
  def change
    add_column :batch_schedules, :start_day, :date
    add_column :batch_schedules, :end_day, :date
    add_column :batch_schedules, :start_hour, :integer
    remove_column :batch_schedules, :today
  end
end
