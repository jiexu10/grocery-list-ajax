require "spec_helper"

feature "user deletes grocery item", js: true do

  scenario "successfully delete grocery item" do
    visit "/groceries"
    fill_in "Name", with: "Peanut Butter"

    expect_no_page_reload do
      click_button "Add"
      expect(page).to have_content "Peanut Butter"
    end

    fill_in "Name", with: "Second item"

    expect_no_page_reload do
      click_button "Add"
      expect(page).to have_content "Second item"
    end

    expect_no_page_reload do
      first('.delete_form').click_button "Delete"
      expect(page).to_not have_content "Peanut Butter"
      expect(page).to have_content "Second item"
    end

    expect_no_page_reload do
      click_button "Delete"
      expect(page).to_not have_content "Peanut Butter"
      expect(page).to_not have_content "Second item"
    end
  end

end
