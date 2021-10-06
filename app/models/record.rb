class Record < ApplicationRecord

  belongs_to :end_user, optional: true
  has_many :post_comments, dependent: :destroy

  attachment :image

  enum genre: { pops: 0, rock: 1, black_music: 2, edm: 3, classic: 4, jazz: 5 }

end
