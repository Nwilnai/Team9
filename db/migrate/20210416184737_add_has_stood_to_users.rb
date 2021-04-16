class AddHasStoodToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :has_stood, :boolean
  end
end
