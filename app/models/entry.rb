class Entry < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :end_user
  belongs_to :room
end
