class RemoveCurrentlyPlayingFromGameSessions < ActiveRecord::Migration[6.1]
  def change
    remove_column :game_sessions, :currently_playing, :boolean
  end
end
