FactoryBot.define do
  factory :review do
      sequence(:title) { |i| "This place is awesome!"}
      rating { 3 }
      sequence(:content) { |i| "The staff was so helpful and the pets are great."  }
      adoptable { "Yes" }
      image { "https://whatyouth.com/wp-content/uploads/2016/03/whatyouth_lizard_submission_photo-256x256.jpg" }
      shelter
  end
end

# - title
# - rating
# - content
# - an optional picture
