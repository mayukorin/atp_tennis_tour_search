class ChangeDataDayToMatch < ActiveRecord::Migration[6.1]
  def change
    change_column :matches, :day, :datetime
  end
end
