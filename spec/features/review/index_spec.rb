require 'rails_helper'

RSpec.describe "Shelter page", type: :feature do

  before :each do
    @shelter1 = Shelter.create(
      name: "the lab",
      address: "123 Dog Street",
      city: "Dog Town",
      state: "DO",
      zip: "12345"
    )
    @shelter2 = Shelter.create(
      name: "starter kit-en",
      address: "999 Felix Ave",
      city: "Cat Alley",
      state: "CA",
      zip: "67890"
    )

    @pet1 = Pet.create(
      name: "Remy",
      age: "10",
      sex: "male",
      image: "https://thesmartcanine.com/wp-content/uploads/2019/09/labrador-pitbull-mix.jpg",
      shelter_id: @shelter1.id
    )

  end
  it "can see shelter name address city state and zip" do

    visit "/shelters/#{@shelter1.id}"
