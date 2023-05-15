class List < ApplicationRecord
  belongs_to :user
  has_many :todos, dependent: :destroy
  has_many :tasks, dependent: :destroy
end
