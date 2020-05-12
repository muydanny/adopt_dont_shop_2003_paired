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
end
