class Task < ApplicationRecord
  belongs_to :list
  validates :content, length: { maximum: 255}
end
