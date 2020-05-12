require 'rails_helper'

RSpec.describe "When I visit a shelter's show page,", type: :feature do
  it "I see a list of reviews for that shelter" do
    shelter = create(:shelter)
    pet = create(:pet, shelter: shelter)
    review = create(:review, shelter: shelter)

    visit "/shelters/#{shelter.id}"

    expect(page).to have_content(review.title)
    expect(page).to have_content("#{review.rating}")
    expect(page).to have_content("#{review.content}")
    expect(page.find("img#review-image-#{review.id}")).to be_truthy
  end
end




# As a visitor,
# When I visit a shelter's show page,
# I see a list of reviews for that shelter
# Each review will have:
# - title
# - rating
# - content
# - an optional picture
