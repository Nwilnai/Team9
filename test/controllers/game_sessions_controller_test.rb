require 'test_helper'

class GameSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game_session = game_sessions(:one)
  end

  test 'should get index' do
    get game_sessions_url
    assert_response :success
  end

  test 'should show game_session' do
    get game_session_url(@game_session)
    assert_response :success
  end

  test 'should get edit' do
    get edit_game_session_url(@game_session)
    assert_response :success
  end

  test 'should destroy game_session' do
    assert_difference('GameSession.count', -1) do
      delete game_session_url(@game_session)
    end

    assert_redirected_to game_sessions_url
  end
end
