FactoryBot.define do
  factory :record do
    title { Faker::Lorem.characters(number: 20) }
    artist_name { Faker::Lorem.characters(number: 20) }
    introduction { Faker::Lorem.characters(number: 100) }
    genre { "rock" }
    release_date { Faker::Date.backward }
  end
end
