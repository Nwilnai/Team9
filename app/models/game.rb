require 'net/http'
require 'json'
class Game < ApplicationRecord
    has_many :game_sessions
    has_many :users, through: :game_sessions


    def init_game
		self.users << User.dealer
        for user in self.users
            cards=draw_cards(2)
            cardcodes=""
            for card in cards do
                cardcodes+= card['code']+","
            end
            cardcodes=cardcodes[0, cardcodes.length-1]
            path= '/api/deck/' + self.get_deck_id + '/pile/userid' + user.id.to_s + '/add/?cards='+cardcodes
            make_API_call(path)
        end
	end

    def init_deck_id
        full_link = 'https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1'
        uri = URI(full_link)
        http = Net::HTTP.new(uri.host)
        req = Net::HTTP::Get.new(uri.path)
        resp = http.request(req)
        
        json_resp=JSON.parse(resp.body)
        #getting our deck id from the response hashmap
        deck_id= json_resp["deck_id"]
        self.update_attribute(:deck_id, deck_id)
    end

    
    def get_deck_id
        if self.deck_id.nil?
            init_deck_id
            self.deck_id
        else
            self.deck_id
        end
    end

    def draw_cards(num_cards)
        path = "/api/deck/"+ self.get_deck_id + "/draw/?count="+ num_cards.to_s
        json_resp=make_API_call(path)
        return json_resp['cards']
    end

    def dealer
		User.dealer
	end

    def make_API_call(path)
        uri = URI('https://deckofcardsapi.com/api/deck/')
        http = Net::HTTP.new(uri.host)
        req = Net::HTTP::Get.new(path)
        resp = http.request(req)
    
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
