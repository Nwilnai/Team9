require 'net/http'
require 'json'

class GameSession < ApplicationRecord
    belongs_to :game
    belongs_to :user

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

    def insert_deck_id(link, deck_id)
        #if the link has the string <<deck_id>>, replace it with the actual deck id. otherwise, don't modify the link'
        if link.include?("<<deck_id>>")
            link=link.sub("<<deck_id>>", deck_id)
        end
        link
    end
    
    def get_deck_id
        if self.deck_id.nil?
            init_deck_id
            self.deck_id
        else
            self.deck_id
        end
    end
end
