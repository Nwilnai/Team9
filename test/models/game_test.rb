require 'test_helper'

class GameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: 'Example User', email: 'user@example.com',
                     password: 'foobar', password_confirmation: 'foobar')
    @game = Game.new()
    @game.add_user(@user)
    @game.init_game
  end

  test 'should have deck_id' do
    assert @game.get_deck_id
  end

  test 'should draw cards' do
    assert @game.draw_cards(1)
  end

  test 'dealer should exist' do
    assert @game.dealer.valid?
  end

  test 'dealer should have hand' do
    assert @game.dealer_hand
  end

  test 'game should finish after dealer finishes their hand' do
    while @game.value(@game.dealer_hand) < 21 do
      @game.dealer.hit_me(@game)
    end
    assert @game.is_round_over?
  end

  test 'user should win when dealer busts' do
    while @game.value(@game.dealer_hand) < 21 do
      @game.dealer.hit_me(@game)
    end
    assert_equal @user, @game.who_won
  end




end
