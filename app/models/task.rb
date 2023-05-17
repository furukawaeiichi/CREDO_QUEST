class Task < ApplicationRecord
  belongs_to :list
  belongs_to :user
  validates :content, length: { maximum: 255}
end
