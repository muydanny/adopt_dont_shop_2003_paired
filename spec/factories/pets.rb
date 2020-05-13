FactoryBot.define do
  factory :pet do
      image { "https://whatyouth.com/wp-content/uploads/2016/03/whatyouth_lizard_submission_photo-256x256.jpg" }
      sequence(:name) { |i| "Frank"}
      age { 3 }
      sex { ["Female", 'Male'].shuffle.first }
      adoptable { "Yes" }
      sequence(:description) { |n| "Only has #{n} diseases!" }
      shelter
  end
  factory :pet1 do
    name {"Dr. Dog"}
    age {34}
    sex {"male"}
    adoptable {true}
    description {"Well educated"}
    image { "https://i.redd.it/4ygdq7e6gze11.jpg" }
    shelter1
  end
  factory :pet2 do
    name {"Oreo"}
    age {3}
    sex {"female"}
    adoptable {false}
    description {"Best if dipped in milk"}
    image { "https://image.shutterstock.com/image-photo/cute-american-shorthair-cat-kitten-260nw-352176329.jpg" }
    shelter1
  end
end
