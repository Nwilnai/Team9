class LeaderboardController < ApplicationController
    def index
        @ranks = rank_users()
    end

    private 

    def rank_users
        ranks = []
        User.all.each do |user|
            token_amount = user.tokens
            ranks.push([user, token_amount])
        end
        ranks.sort_by {|var| var[1]}
    end
end
