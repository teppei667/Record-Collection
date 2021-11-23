class PostComment < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :end_user
  belongs_to :record

  validates :comment, presence: true, length: { minimum: 1, maximum: 100 }
end
