class AddBetAmountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :bet_amount, :integer, default: 0
  end
end
