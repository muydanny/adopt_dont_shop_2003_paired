FactoryBot.define do
  factory :shelter do
    name { "Dumb Friends League" }
    address  { "123 fake st" }
    city { "Denver" }
    state { "CO" }
    zip { 80134 }
  end

  factory :shelter1 do
    name { "Barks and Crafts" }
    address  { "123 K9 st" }
    city { "Newfoundland" }
    state { "DG" }
    zip { 12345 }
  end

  factory :shelter2 do
    name { "pug place" }
    address  { "123 pup st" }
    city { "pugtown" }
    state { "PG" }
    zip { 33333 }
  end
end
