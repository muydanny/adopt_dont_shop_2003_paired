require 'rails_helper'

RSpec.describe "When I visit a shelter's show page,", type: :feature do
  xit "I see a list of reviews for that shelter" do
    shelter = create(:shelter)
    pet = create(:pet, shelter: shelter)
    review = create(:review, shelter: shelter)

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content(review.title)
    expect(page).to have_content("#{shelter.rating}")
    expect(page).to have_content("#{shelter.content}")
    expect(page.find("img#pet-image-#{review.id}")).to be_truthy
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
