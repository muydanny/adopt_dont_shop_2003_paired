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
