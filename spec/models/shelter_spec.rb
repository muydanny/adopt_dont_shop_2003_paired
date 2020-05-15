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

  it "should identify if shelters have adopoption pending pets" do



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
      name: "bbbb",
      address: "999 Felix Ave",
      city: "Cat Alley",
      state: "CA",
      zip: "67890"
    )
    @pet1 = Pet.create(
      name: "many pets",
      age: "4",
      sex: "male",
      description: "a bit mischevious",
      image: "https://thesmartcanine.com/wp-content/uploads/2019/09/sealyham-terrier-small-dog.jpg",
      shelter_id: @shelter1.id,
      adoptable: true
    )
    @pet2 = Pet.create(
      name: "Penny",
      age: "55",
      sex: "female",
      description: "known to eat goose poop",
      image: "https://www.rover.com/blog/wp-content/uploads/2019/05/puppy-in-bowl.jpg",
      shelter_id: @shelter1.id,
      adoptable: false
    )
    @pet3 = Pet.create(
      name: "Aggie",
      age: "25",
      sex: "female",
      description: "a rabbit",
      image: "https://www.rover.com/blog/wp-content/uploads/2019/05/puppy-in-bowl.jpg",
      shelter_id: @shelter2.id,
      adoptable: false
    )

    expect(@shelter1.pending?).to eq(true)
    expect(@shelter2.pending?).to eq(true)
    expect(@shelter3.pending?).to eq(false)
  end

  it "can average shelter reviews" do
    shelter1 = Shelter.create(name: "S1", address: "A1",city: "C1",state: "ST",zip: "12345")
    shelter2 = Shelter.create(name: "S2", address: "A2",city: "C2",state: "ST",zip: "12345")
    shelter3 = Shelter.create(name: "S3", address: "A3",city: "C3",state: "ST",zip: "12345")
    review1 = shelter1.reviews.create(title: "R1", rating: 1, content: "na", image: "img" )
    review11 = shelter1.reviews.create(title: "R11", rating: 4, content: "na", image: "img" )
    review111 = shelter1.reviews.create(title: "R11", rating: 5, content: "na", image: "img" )
    review2 = shelter2.reviews.create(title: "R2", rating: 1, content: "na", image: "img" )
    review22 = shelter2.reviews.create(title: "R22", rating: 3, content: "na", image: "img" )
    review222 = shelter2.reviews.create(title: "R222", rating: 5, content: "na", image: "img" )


    expect(shelter1.average_review_rating).to eq(3.3)
    expect(shelter2.average_review_rating).to eq(3)
    expect(shelter3.average_review_rating).to eq("n/a")
  end

  it "can count apps for its pets" do
    shelter1 = Shelter.create(name: "S1", address: "A1",city: "C1",state: "ST",zip: "12345")
    shelter2 = Shelter.create(name: "S2", address: "A2",city: "C2",state: "ST",zip: "12345")
    shelter3 = Shelter.create(name: "S3", address: "A3",city: "C3",state: "ST",zip: "12345")
    pet1 = shelter1.pets.create(name: "P1",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    pet11 = shelter1.pets.create(name: "P11",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    pet111 = shelter1.pets.create(name: "P111",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    pet2 = shelter2.pets.create(name: "P2",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    pet22 = shelter2.pets.create(name: "P22",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    pet222 = shelter2.pets.create(name: "P222",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    pet3 = shelter3.pets.create(name: "P3",age: "1",sex: "male",description: "d1",image: "i1",adoptable: true)
    app1 = App.create(name:"A1", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc",approved:"false")
    app111 = App.create(name:"A111", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc",approved:"false")
    app2 = App.create(name:"A2", address: "a1", city: "C1", state: "ST", zip: "12345", phone_number: "12345678", description:"desc",approved:"false")
    PetApp.create(pet: pet1, app: app1)
    PetApp.create(pet: pet1, app: app111)
    PetApp.create(pet: pet11, app: app1)
    PetApp.create(pet: pet111, app: app111)
    PetApp.create(pet: pet2, app: app2)
    PetApp.create(pet: pet22, app: app2)


    expect(shelter1.app_count).to eq(2)
    expect(shelter2.app_count).to eq(1)
    expect(shelter3.app_count).to eq(0)
  end

end
