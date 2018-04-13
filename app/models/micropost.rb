class Micropost < ApplicationRecord
  belongs_to :user
  has_many :favorited ,class_name: 'Favorite',foreign_key: 'micropost_id'
  has_many :favorites
  
  validates :user_id, presence: true
  validates :content, presence: true, length:{maximum: 255}
end