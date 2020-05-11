require 'rails_helper'

RSpec.describe "pet create ", type: :feature do
  before :each do
    @shelter1 = Shelter.create(
      name: "the lab",
      address: "123 Dog Street",
      city: "Dog Town",
      state: "DO",
      zip: "12345"
    )

  end

  it "can create a pet on pets index" do
    visit "shelters/#{@shelter1.id}/pets"
    expect(page).not_to have_content("Remy")
    expect(page).not_to have_content("Approximate age: 10")
    expect(page).not_to have_content("Name of shelter: the lab")
    expect(page).not_to have_css("img[src*='https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg']")
    click_link("Create Pet")


    fill_in "name", with: "Remy"
    fill_in "age", with: "10"
    # choose("male")
    fill_in "image", with: "https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg"
    click_button "Create Pet"

    expect(page).to have_content("Remy")
    expect(page).to have_content("10")
    expect(page).to have_content("the lab")
    expect(page).to have_css("img[src*='https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg']")
    expect(page).to have_content("10")
end

it "can create a pet on shelter show" do
  visit "shelters/#{@shelter1.id}"

  expect(page).not_to have_content("Remy")
  expect(page).not_to have_content("Approximate age: 10")
  expect(page).not_to have_content("Name of shelter: the lab")
  expect(page).not_to have_css("img[src*='https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg']")
  click_link("Create Pet")


  fill_in "name", with: "Remy"
  fill_in "age", with: "10"
  # choose("male")
  fill_in "image", with: "https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg"
  click_button "Create Pet"

  expect(page).to have_content("Remy")
  expect(page).to have_content("10")
  expect(page).to have_content("the lab")
  expect(page).to have_css("img[src*='https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg']")
  expect(page).to have_content("10")
end



end
