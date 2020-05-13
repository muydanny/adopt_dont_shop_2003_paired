require 'rails_helper'

RSpec.describe "When I fail to enter a title, rating, content" do
  it "I see a flash message indicating that I need to fill in form" do
    shelter = create(:shelter)
    pet = create(:pet, shelter: shelter)

    visit "/shelters/#{shelter.id}/new_review"
    expect(find_button("Submit")).to be_truthy

    expect(current_path).to eq("/shelters/#{shelter.id}/new_review")

    fill_in :review_title, with: "This place rocks!"

    click_button("Submit")
    expect(current_path).to eq("/shelters/#{shelter.id}/new_review")
    expect(page).to have_content("Please fill out entire form")
  end
end


# When I fail to enter a title, a rating, and/or content in the new shelter
# review form, but still try to submit the form
# I see a flash message indicating that I need to fill in a
# title, rating, and content in order to submit a shelter review
# And I'm returned to the new form to create a new review
