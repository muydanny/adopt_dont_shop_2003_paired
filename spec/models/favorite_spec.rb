require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before :each do
    @shelter1 = Shelter.create(
      name: "the lab",
      address: "666 dog Ave",
      city: "ruff town",
      state: "DG",
      zip: "12345"
    )
    @pet1 = Pet.create(
      name: "Dr. Dog",
      age: "4",
      sex: "male",
      description: "well educated",
      image: "https://i.redd.it/4ygdq7e6gze11.jpg",
      shelter_id: @shelter1.id,
      adoptable: true
    )
    @pet2 = Pet.create(
      name: "Oreo",
      age: "55",
      sex: "female",
      description: "best if dipped in milk",
      image: "https://image.shutterstock.com/image-photo/cute-american-shorthair-cat-kitten-260nw-352176329.jpg",
      shelter_id: @shelter1.id,
      adoptable: false
    )
  end
  describe "validates values" do
    # it {should have_many :pets}
  end

  it "can calculate the total number of pets in favorites" do
    favorite = Favorite.new({
      1 => 1,
      2 => 1
      })

    expect(favorite.total_count).to eq(2)
  end

  it "can add pet to favorites" do
    favorite = Favorite.new({})
    favorite.add_pet(@pet1.id)

    expect(favorite.total_count).to eq(1)
    favorite_pet_id = favorite.contents.keys.first.to_i
    favorite_pet_name = Pet.find(favorite_pet_id).name
    expect(@pet1.name).to eq (favorite_pet_name)
  end

  it "can count ids" do
    favorite = Favorite.new({})
    favorite.add_pet(@pet1.id)
    expect(favorite.count_of(@pet1.id)).to eq(1)
    expect(favorite.count_of(@pet2.id)).to eq(0)
  end

  it "can return favorite pets" do
    favorite = Favorite.new({
      @pet1.id => 1,
      @pet2.id => 1
      })

      expect(favorite.favorite_pets).to eq([@pet1, @pet2])
  end
end
