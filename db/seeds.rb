# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Shelter.create(name: "Pick a Pet", address: "1234 Fake St", city: "Denver", state: "CO", zip: "80209")
Shelter.create(name: "Pets!", address: "1111 Random Ave", city: "Denver", state: "CO", zip: "80223")
shelter_1 = Shelter.create(name: "the lab", address: "666 dog Ave", city: "ruff town", state: "DG", zip: "12345")
Shelter.create(name: "Lions and House Cats Only", address: "44 Elm St", city: "Denver", state: "CO", zip: "81005")
Shelter.create(name: "Big Al's House", address: "605 8th St", city: "Denver", state: "CO", zip: "83023")
Shelter.create(name: "Paws, Prints, and Pies", address: "333 N St", city: "Denver", state: "CO", zip: "84223")
shelter_2 = Shelter.create(name: "Free Animals", address: "101 Pearl St", city: "Denver", state: "CO", zip: "80123")



shelter1 = Shelter.create(
  name: "the lab",
  address: "666 dog Ave",
  city: "ruff town",
  state: "DG",
  zip: "12345"
)
pet1 = Pet.create(
  name: "Walter",
  age: "4",
  sex: "male",
  description: "a bit mischevious",
  image: "https://thesmartcanine.com/wp-content/uploads/2019/09/sealyham-terrier-small-dog.jpg",
  shelter_id: shelter1.id
)
