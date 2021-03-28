class RemoveDeckIdFromGameSessions < ActiveRecord::Migration[6.1]
  def change
    remove_column :game_sessions, :deck_id, :string
  end
end
