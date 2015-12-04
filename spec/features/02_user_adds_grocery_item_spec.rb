require "spec_helper"

feature "user add grocery item", js: true do

  scenario "successfully add grocery item" do
    visit "/groceries"
    fill_in "Name", with: "Peanut Butter"

    expect_no_page_reload do
      click_button "Add"
      expect(page).to have_content "Peanut Butter"
    end
  end

  scenario "submit form without name" do
    visit "/groceries"

    expect_no_page_reload do
      click_button "Add"
      expect(page).to_not have_css("li")
    end
  end
end
