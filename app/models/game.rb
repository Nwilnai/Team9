require 'net/http'
require 'json'
class Game < ApplicationRecord
    has_many :game_sessions
    has_many :users, through: :game_sessions

    #initializes the game by creating a dealer, adding them to this game's users.
    #the deck is also initialized, and a pile for each user is created.
    #the api takes care of all this, so we just need to make the right requests.
    #NOTE: USER PILES ALWAYS LOOK LIKE: userid<user_id>
    #such that a user with an id of 5 will have a pile: userid5
    def init_game
		self.users << User.dealer
        for user in self.users
            #draw 2 cards per user
            cards=draw_cards(2)
            #grab all card codes, seperated by commas
            cardcodes=""
            for card in cards do
                cardcodes+= card['code']+","
            end
            #remove extraneous comma
            cardcodes=cardcodes[0, cardcodes.length-1]
            #add cards to user piles
            path= '/api/deck/' + self.get_deck_id + '/pile/userid' + user.id.to_s + '/add/?cards='+cardcodes
            make_API_call(path)
        end
	end

    #initializes the deck for this game by making initializing call to api
    def init_deck_id
        path = '/api/deck/new/shuffle/?deck_count=1'
        json_resp=make_API_call(path)
        #getting our deck id from the response hashmap
        deck_id= json_resp["deck_id"]
        self.update_attribute(:deck_id, deck_id)
    end

    #returns the deck_id if it has been created, 
    #otherwise creates a deck and returns the saved id
    def get_deck_id
        if self.deck_id.nil?
            init_deck_id
            self.deck_id
        else
            self.deck_id
        end
    end

    #makes call to API to draw num_cards amount of cards
    def draw_cards(num_cards)
        path = "/api/deck/"+ self.get_deck_id + "/draw/?count="+ num_cards.to_s
        json_resp=make_API_call(path)
        return json_resp['cards']
    end

    #returns the dealer
    def dealer
		User.dealer
	end

    #returns dealer's hand
    def dealer_hand
		dealer.hand(self)
	end
    #game ends when one player has cards with value >=21
    def game_is_done?
		 return self.users.find { |u| value(u.hand(self)) >= 21 } 
	end

    #returns user/s who are busted
    def busted_users
		self.users.find { |u| value(u.hand(self)) > 21 } 
	end
    #returns user/s who are not busted
	def nonbusted_users
		self.users.find { |u| value(u.hand(self)) <= 21 } 
	end

    #returns user/s who have an exact hand value of 21
    def twentyone_users
		self.users.find { |u| value(u.hand(self)) == 21 }
	end
    #returns who won the game.
    def who_won
		winner = nil
		if self.game_is_done? then
			if busted_users 
			    if twentyone_users 
				    winner = twentyone_users
                else
                    winner = nonbusted_users
			    end
            else
                if twentyone_users 
				    winner = twentyone_users
                end
            end
		end
		return winner
	end

    #calculates the value of a hand. 
    # any card with an integer value is worth that amount
    # any titled card is worth 10 points (such as King, Queen, etc.)
    # an ace can either be worth 1 or 11 points, whichever helps the user 
    # get as close to 21 as possible
    def value(hand)
        ace_count= 0
        hand_total=0
        #for every card in hand do
        hand.each do |card|
            if(card['value'].downcase == "ace" )
                ace_count +=1
            elsif(card['value'].to_i == 0)
                hand_total+=10
            else
                hand_total+=card['value'].to_i
            end
        end
        #if there are aces
        if ace_count > 0
            #add 1 to hand for every ace
            hand_total += ace_count
            #can the user afford to make aces count as 11?
            while(hand_total +10 <= 21 && ace_count > 0)
                hand_total+=10
                ace_count-=1
            end
        end
        return hand_total
    end

    #lets you make a call to the api using a particular path. This is done because 
    #the uri dropped arguments in the path on occasion (particularly "count?="),
    #so we use the user provided path instead of a uri generated path.
    def make_API_call(path)
        #make other parts of uri using generic api link
        uri = URI('https://deckofcardsapi.com/api/deck/')
        http = Net::HTTP.new(uri.host)
        #uses user provided path to make api request
        req = Net::HTTP::Get.new(path)
        resp = http.request(req)
        #sometimes api response fails out of nowhere for unknown reason, 
        #double check to make sure it isn't a one-time error before returning false
        if(resp.body == "<h1>Server Error (500)</h1>" )
            resp = http.request(req)
            if(resp.body == "<h1>Server Error (500)</h1>" )
                return false
              end
        end
        json_resp=JSON.parse(resp.body)
        #return parsed api response
        json_resp
      end
      
end
