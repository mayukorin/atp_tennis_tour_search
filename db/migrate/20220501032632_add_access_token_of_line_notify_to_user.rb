class AddAccessTokenOfLineNotifyToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :access_token_of_line_notify, :string
  end
end
