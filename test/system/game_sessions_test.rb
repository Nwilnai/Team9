require "application_system_test_case"

class GameSessionsTest < ApplicationSystemTestCase
  setup do
    @game_session = game_sessions(:one)
  end

  test "visiting the index" do
    visit game_sessions_url
    assert_selector "h1", text: "Game Sessions"
  end

  test "creating a Game session" do
    visit game_sessions_url
    click_on "New Game Session"

    fill_in "Game", with: @game_session.game_id
    fill_in "User", with: @game_session.user_id
    click_on "Create Game session"

    assert_text "Game session was successfully created"
    click_on "Back"
  end

  test "updating a Game session" do
    visit game_sessions_url
    click_on "Edit", match: :first

    fill_in "Game", with: @game_session.game_id
    fill_in "User", with: @game_session.user_id
    click_on "Update Game session"

    assert_text "Game session was successfully updated"
    click_on "Back"
  end

  test "destroying a Game session" do
    visit game_sessions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Game session was successfully destroyed"
  end
end
