class Record < ApplicationRecord

  belongs_to :end_user, optional: true
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  attachment :image

  enum genre: { pops: 0, rock: 1, black_music: 2, edm: 3, classic: 4, jazz: 5 }

  #いいね済みかどうか確認する
  def favorited_by?(end_user)
    favorites.where(end_user_id: end_user.id).exists?
  end


  def self.record_search(keyword)
    where(["title like? OR introduction like? OR artist_name like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end
end
