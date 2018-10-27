require "application_system_test_case"

class MemoriesTest < ApplicationSystemTestCase
  setup do
    @memory = memories(:one)
  end

  test "visiting the index" do
    visit memories_url
    assert_selector "h1", text: "Memories"
  end

  test "creating a Memory" do
    visit memories_url
    click_on "New Memory"

    fill_in "Date", with: @memory.date
    fill_in "Description", with: @memory.description
    fill_in "Local", with: @memory.local
    fill_in "User", with: @memory.user_id
    fill_in "Weather", with: @memory.weather
    click_on "Create Memory"

    assert_text "Memory was successfully created"
    click_on "Back"
  end

  test "updating a Memory" do
    visit memories_url
    click_on "Edit", match: :first

    fill_in "Date", with: @memory.date
    fill_in "Description", with: @memory.description
    fill_in "Local", with: @memory.local
    fill_in "User", with: @memory.user_id
    fill_in "Weather", with: @memory.weather
    click_on "Update Memory"

    assert_text "Memory was successfully updated"
    click_on "Back"
  end

  test "destroying a Memory" do
    visit memories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Memory was successfully destroyed"
  end
end
