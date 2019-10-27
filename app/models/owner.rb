class Owner < ApplicationRecord
  validates :name, presence: true
  validates_uniqueness_of :name

  has_many :todo_owners
  has_many :todos, through: :todo_owners
end

