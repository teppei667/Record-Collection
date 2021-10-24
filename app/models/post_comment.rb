class PostComment < ApplicationRecord
  belongs_to :end_user
  belongs_to :record

   validates :comment, presence: true, length: { minimum: 1, maximum: 100 }
end
