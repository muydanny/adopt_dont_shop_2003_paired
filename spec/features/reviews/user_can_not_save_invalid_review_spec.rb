require 'rails_helper'

RSpec.describe "When I fail to enter a title, rating, content" do
  it "I see a flash message indicating that I need to fill in form" do
    shelter = create(:shelter)
    review = create(:review, shelter: shelter)

    visit "/shelters/#{shelter.id}/new_review"
    expect(find_button("Create Review")).to be_truthy

    expect(current_path).to eq("/shelters/#{shelter.id}/new_review")

    fill_in :title, with: "This place rocks!"

    click_button("Create Review")
    expect(current_path).to eq("/shelters/#{shelter.id}/new_review")
    expect(page).to have_content("Please fill out entire form")
  end
end
