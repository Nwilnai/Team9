class AddWinsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :wins, :integer
  end
end
