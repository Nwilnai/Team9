class Game < ApplicationRecord
    has_many :game_sessions
    has_many :users, through: :game_sessions

    after_create do
		self.users << User.dealer
	end
    def dealer
		User.dealer
	end
    
end
