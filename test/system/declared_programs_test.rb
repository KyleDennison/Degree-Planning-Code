require "application_system_test_case"

class DeclaredProgramsTest < ApplicationSystemTestCase
  setup do
    @declared_program = declared_programs(:one)
  end

  test "visiting the index" do
    visit declared_programs_url
    assert_selector "h1", text: "Declared Programs"
  end

  test "creating a Declared program" do
    visit declared_programs_url
    click_on "New Declared Program"

    fill_in "Major", with: @declared_program.major_id
    fill_in "User", with: @declared_program.user_id
    click_on "Create Declared program"

    assert_text "Declared program was successfully created"
    click_on "Back"
  end

  test "updating a Declared program" do
    visit declared_programs_url
    click_on "Edit", match: :first

    fill_in "Major", with: @declared_program.major_id
    fill_in "User", with: @declared_program.user_id
    click_on "Update Declared program"

    assert_text "Declared program was successfully updated"
    click_on "Back"
  end

  test "destroying a Declared program" do
    visit declared_programs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Declared program was successfully destroyed"
  end
end
