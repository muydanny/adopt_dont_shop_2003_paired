

RSpec.describe "Create a review page" do
  it "can write review" do
    shelter = create(:shelter)
    pet = create(:pet, shelter: shelter)
    review = create(:review, shelter: shelter)

    visit "/shelters/#{shelter.id}"

    click_link "Review this shelter!"
    expect(current_path).to eq("/shelters/#{shelter.id}/new_review")

    fill_in :title, with: "This place rocks!"
    fill_in :rating, with: 4
    fill_in :content, with: "I have never been treated so well! My Pets love it here."

    click_button("Create Review")
    expect(current_path).to eq("/shelters/#{shelter.id}")
    expect(page).to have_content("This place rocks!")
    expect(page).to have_content(4)
    expect(page).to have_content("I have never been treated so well! My Pets love it here.")
  end
end
