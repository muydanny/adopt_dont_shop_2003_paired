

RSpec.describe "Create a review page" do
  it "can write review" do
    shelter = create(:shelter)
    pet = create(:pet, shelter: shelter)
    review = create(:review, shelter: shelter)

    visit "/shelters/#{shelter.id}"

    click_link "Review this shelter!"
    expect(current_path).to eq("/shelters/#{shelter.id}/new_review")

    fill_in :review_title, with: "This place rocks!"
    fill_in :review_rating, with: 4
    fill_in :review_content, with: "I have never been treated so well! My Pets love it here."

    click_button("Submit")
    expect(current_path).to eq("/shelters/#{shelter.id}")
    expect(page).to have_content("This place rocks!")
    expect(page).to have_content(4)
    expect(page).to have_content("I have never been treated so well! My Pets love it here.")
  end
end

  # When I visit a shelter's show page
  # I see a link to add a new review for this shelter.
  # When I click on this link, I am taken to a new review path
  # On this new page, I see a form where I must enter:
  # - title
  # - rating
  # - content
  # I also see a field where I can enter an optional image (web address)
  # When the form is submitted, I should return to that shelter's show page
  # and I can see my new review
