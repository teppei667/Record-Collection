class Room < ApplicationRecord
  
  has_many :entries, dependent: :destroy
  has_many :direct_messages, dependent: :destroy
  has_many :end_users, through: :entries
  
end
