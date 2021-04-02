class User < ApplicationRecord
    has_many :game_sessions
    has_many :games, through: :game_sessions

    attr_accessor :remember_token
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end 

   # Returns true if the given token matches the digest.
   def authenticated?(remember_token)
    return false if remember_digest.nil?
  BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end


  #lets you make a call to the api using a particular path. This is done because 
    #the uri dropped arguments in the path on occasion (particularly "count?="),
    #so we use the user provided path instead of a uri generated path.
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

  #returns the existing dealer user, or creates dealer and returns
  def self.dealer
		User.find_by_name( "dealer") || User.create( :name => "dealer", :email => "dealer@dealer.com", :password => "dealer" )
	end

  #show this user's hand via call to API
  def hand(current_game)
    #make call with deck id and player inserted in and return only the current players hand
    path= '/api/deck/' + current_game.get_deck_id + '/pile/userid' + self.id.to_s + '/list/'
    result= make_API_call(path)
    hand= result['piles']["userid"+self.id.to_s]['cards']
  end

  #card looks like: 
  #{"code"=>"AH", "image"=>"https://deckofcardsapi.com/static/img/AH.png", 
  #"images"=>{"svg"=>"https://deckofcardsapi.com/static/img/AH.svg", 
  #"png"=>"https://deckofcardsapi.com/static/img/AH.png"}, 
  #"value"=>"ACE", "suit"=>"HEARTS"}
  def hit_me(current_game)
    card=current_game.draw_cards(1).first
    path= '/api/deck/' + current_game.get_deck_id + '/pile/userid' + self.id.to_s + '/add/?cards=' + card['code']
    make_API_call(path)
  end

  def dealer_hit?(game)
		game.value(game.dealer.hand(game)) < 17
	end

end