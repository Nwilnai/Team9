class ChangeColumnWinsInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :wins, :integer, default: 0
  end
end
