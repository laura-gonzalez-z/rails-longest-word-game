require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "div.shadow", count: 10
  end

  test "Fill with random word" do
    visit new_url
    fill_in "word", with: "friendly"
    click_on "Play"
    assert_text "can't be build"
  end

  test "Fill with one-letter word" do
    visit new_url
    fill_in "word", with: "p"
    click_on "Play"
    assert_text "does not seem to be a valid English Word"
  end

  test "Fill with english word" do
    visit new_url
    fill_in "word", with: "do"
    click_on "Play"
    assert_text "Congratulations"
  end
end
