FactoryBot.define do
  factory :end_user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number: 100) }
    password { "123456" }
  end
end
