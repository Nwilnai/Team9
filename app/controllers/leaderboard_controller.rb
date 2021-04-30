class LeaderboardController < ApplicationController
    def index
        @ranks = rank_users()
    end

    private 

    def rank_users
        ranks = []
        User.all.each do |user|
            if user.tokens.nil? == false
                token_amount = user.tokens
                ranks.push([user, token_amount])
            end
        end
        return ranks.sort_by{|var| var[1]}.reverse
    end
end
