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

  def make_API_call(full_link)
    uri = URI(full_link)
    http = Net::HTTP.new(uri.host)
    req = Net::HTTP::Get.new(uri.path)
    resp = http.request(req)
    
    json_resp=JSON.parse(resp.body)
    #return parsed api response
    json_resp
  end

  def self.dealer
		User.find_by_name( "dealer") || User.create( :name => "dealer", :email => "dealer@dealer.com", :password => "dealer" )
	end

  def insert_deck_id(link, deck_id)
    #if the link has the string <<deck_id>>, replace it with the actual deck id. otherwise, don't modify the link'
    if link.include?("<<deck_id>>")
        link=link.sub("<<deck_id>>", deck_id)
    end
    link
  end

  def hand
    #make call with deck id and player inserted in and return only the current players hand
    link= 'https://deckofcardsapi.com/api/deck/'+@game_session.get_deck_id+'/pile/'+current_user.id+'/list/'
    result= make_API_call(link)
    hand= result['piles'][current_user.id]
  end
end