class List < ApplicationRecord
  has_many :todos
  has_many :tasks
end
