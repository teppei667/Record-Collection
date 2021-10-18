class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :records, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :entries
  has_many :direct_messages
  has_many :rooms, through: :entries

  # 自分がフォローされる側
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分がフォローする側
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォロー、フォロワー一覧機能実装の為
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 500 }

  def follow(end_user_id)
    relationships.create(followed_id: end_user_id)
  end

  def unfollow(end_user_id)
    relationships.find_by(followed_id: end_user_id).destroy
  end

  def following?(end_user)
    followings.include?(end_user)
  end

  def self.end_user_search(keyword)
    where(["name like?", "%#{keyword}%"])
  end
end
