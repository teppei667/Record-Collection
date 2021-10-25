FactoryBot.define do
  factory :relationship do
    follower_id { FactoryBot.create(:end_user).id }
    followed_id { FactoryBot.create(:end_user).id }
  end
end
