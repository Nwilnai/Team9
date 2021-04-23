class AddIsGameDoneToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :is_game_done, :boolean, default: false
  end
end
