class Task < ApplicationRecord
  belongs_to :list
  belongs_to :user
  validates :content, presence: true, length: { maximum: 255 }
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  paginates_per 15
end
