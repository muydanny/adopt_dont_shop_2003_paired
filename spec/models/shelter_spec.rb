require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe "validates values" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  it "can list shelters in alphabetical order" do

    @shelter1 = Shelter.create(
      name: "ZZZZZ",
      address: "123 Dog Street",
      city: "Dog Town",
      state: "DO",
      zip: "12345"
    )
    @shelter2 = Shelter.create(
      name: "aaaa",
      address: "999 Felix Ave",
      city: "Cat Alley",
      state: "CA",
      zip: "67890"
    )
    params = {}
    expect(Shelter.shelter_list(params)).to eq([@shelter1, @shelter2])
    params = {:alphabetical => "true"}
    expect(Shelter.shelter_list(params)).to eq([@shelter2, @shelter1])
  end

  it "can list shelters by number of pets" do

    @shelter1 = Shelter.create(
      name: "ZZZZZ",
      address: "123 Dog Street",
      city: "Dog Town",
      state: "DO",
      zip: "12345"
    )
    @shelter2 = Shelter.create(
      name: "aaaa",
      address: "999 Felix Ave",
      city: "Cat Alley",
      state: "CA",
      zip: "67890"
    )
    @shelter3 = Shelter.create(
      name: "no pets",
      address: "888 fluff way",
      city: "Fur ball",
      state: "PT",
      zip: "55555"
    )
    @pet1 = Pet.create(
      name: "many pets",
      age: "4",
      sex: "male",
      description: "a bit mischevious",

      image: "https://thesmartcanine.com/wp-content/uploads/2019/09/sealyham-terrier-small-dog.jpg",
      shelter_id: @shelter2.id,
      adoptable: true
    )

    @pet2 = Pet.create(
      name: "Penny",
      age: "55",
      sex: "female",
      description: "known to eat goose poop",

      image: "https://www.rover.com/blog/wp-content/uploads/2019/05/puppy-in-bowl.jpg",
      shelter_id: @shelter2.id,
      adoptable: true
    )
    @pet3 = Pet.create(
      name: "Aggie",
      age: "25",
      sex: "female",
      description: "a rabbit",

      image: "https://www.rover.com/blog/wp-content/uploads/2019/05/puppy-in-bowl.jpg",
      shelter_id: @shelter1.id,
      adoptable: true
    )
    params = {}
    expect(Shelter.shelter_list(params)).to eq([@shelter1, @shelter2, @shelter3])
    params = {:num_pets => "true"}
    expect(Shelter.shelter_list(params)).to eq([@shelter2, @shelter1, @shelter3])
  end

end
