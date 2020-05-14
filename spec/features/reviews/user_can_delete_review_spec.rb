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

# When I visit a shelter's show page,
# I see a link next to each shelter review to delete the review.
# When I delete a shelter review I am returned to the shelter's show page
# And I should no longer see that shelter review
