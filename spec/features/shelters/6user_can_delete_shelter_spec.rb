require 'rails_helper'

RSpec.describe "Shleters can be deleted ", type: :feature do
  before :each do
    @shelter1 = Shelter.create(
      name: "figaro figaro figaro",
      address: "123 the shop",
      city: "disney",
      state: "DI",
      zip: "33333"
    )
  end

  it "can delete a shelter from index" do
    visit "/shelters"
    expect(page).to have_content("figaro figaro figaro")
    click_button "Delete #{@shelter1.name}"
    expect(current_path).to eq("/shelters")
    expect(page).not_to have_content("figaro figaro figaro")
  end

  it "can delete a shelter from show" do
    visit "/shelters/#{@shelter1.id}"

    expect(page).to have_content("Name: #{@shelter1.name}")
    expect(page).to have_content("Address: #{@shelter1.address}")
    expect(page).to have_content("City: #{@shelter1.city}")
    expect(page).to have_content("State: #{@shelter1.state}")
    expect(page).to have_content("Zip: #{@shelter1.zip}")

    click_button "Delete #{@shelter1.name}"

    expect(current_path).to eq("/shelters")

    expect(page).not_to have_content("Name: #{@shelter1.name}")
    expect(page).not_to have_content("Address: #{@shelter1.address}")
    expect(page).not_to have_content("City: #{@shelter1.city}")
    expect(page).not_to have_content("State: #{@shelter1.state}")
    expect(page).not_to have_content("Zip: #{@shelter1.zip}")
  end

  it "if you delete a shelter the reviews are also deleted" do

    shelter1 = create(:shelter)
    shelter2 = create(:shelter)
    review1 = create(:review, shelter: shelter1)
    review11 = create(:review, shelter: shelter1)
    review2 = create(:review, shelter: shelter2)

    shelter_ids = Shelter.all.map{|shelter| shelter[:id]}
    review_ids = Review.all.map{|review| review[:id]}

    expect(shelter_ids.include?(shelter1.id)).to eq(true)
    expect(review_ids.include?(review1.id)).to eq(true)

    visit "/shelters/#{shelter1.id}"

    expect(page).to have_content(review1.content)
    within("#review-#{review1.id}")do
      click_link("Delete Review")
    end
    review_ids = Review.all.map{|review| review[:id]}
    expect(review_ids.include?(review1.id)).to eq(false)

    visit "/shelters"

    within("#shelter-#{shelter1.id}")do
      within(".delete-form")do
      click_button("Delete #{shelter1.name}")
      end
    end
    review_ids = Review.all.map{|review| review[:id]}
    expect(review_ids.include?(review1.id)).to eq(false)
    expect(review_ids.include?(review11.id)).to eq(false)
    shelter_ids = Shelter.all.map{|shelter| shelter[:id]}
    expect(shelter_ids.include?(shelter1.id)).to eq(false)
    expect(shelter_ids.include?(shelter2.id)).to eq(true)

  end

end
