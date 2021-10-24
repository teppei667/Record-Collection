FactoryBot.define do
  factory :post_comment do
    comment { Faker::Lorem.characters(number:50) }
    association :end_user
    association :record
  end
end