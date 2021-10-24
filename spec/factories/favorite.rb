FactoryBot.define do
  factory :favorite do
    association :end_user
    association :record
  end
end
