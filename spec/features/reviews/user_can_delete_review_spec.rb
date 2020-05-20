require 'rails_helper'

RSpec.describe "When I visit a shelter's show page" do
  it "I see a link to delete the review" do
    shelter = create(:shelter)
    review = create(:review, shelter: shelter)

    visit "/shelters/#{shelter.id}"
    expect(page).to have_content(shelter.name)
    expect(page).to have_content(review.title)

    click_link("Delete Review")

    expect(current_path).to eq("/shelters/#{shelter.id}")
    expect(page).not_to have_content(review.title)
    expect(page).not_to have_content(review.content)
    expect(page).not_to have_css("img#review-image-#{review.id}")
  end
end
