require 'rails_helper'

RSpec.describe "When I visit a shelter's show page" do
  it "edit the shelter review" do
    shelter = create(:shelter)
    review = create(:review, shelter: shelter)

    visit "/shelters/#{shelter.id}"
    expect(page).to have_content(shelter.name)
    click_link("Edit Review")

    expect(current_path).to eq("/shelters/#{shelter.id}/reviews/#{review.id}/edit")

    fill_in( :title, :with => "Nevermind, hate it here")

    expect do
      click_button("Edit Review")
    end.to change { review.reload.title }

    expect(current_path).to eq("/shelters/#{shelter.id}")
  end
end





# When I visit a shelter's show page
# I see a link to edit the shelter review next to each review.
# When I click on this link, I am taken to an edit shelter review path
# On this new page, I see a form that includes that review's pre populated data:
# - title
# - rating
# - content
# - image
# I can update any of these fields and submit the form.
# When the form is submitted, I should return to that shelter's show page
# And I can see my updated review
