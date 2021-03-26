class CreateGameSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :game_sessions do |t|
      t.integer :user_id
      t.integer :game_id
      t.boolean :currently_playing

      t.timestamps
    end
  end
end
