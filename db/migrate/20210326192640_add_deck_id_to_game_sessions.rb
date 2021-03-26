class AddDeckIdToGameSessions < ActiveRecord::Migration[6.1]
  def change
    add_column :game_sessions, :deck_id, :string
  end
end
