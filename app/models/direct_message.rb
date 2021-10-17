class DirectMessage < ApplicationRecord
  belongs_to :end_user
  belongs_to :room

  after_create_commit { DirectMessageBroadcastJob.perform_later self }
end
