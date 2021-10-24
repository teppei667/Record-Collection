class Contact < ApplicationRecord
  
  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :email, presence: true
  validates :message, presence: true, length: { minimum: 2, maximum: 500 }
end
