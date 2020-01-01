class Todo < ApplicationRecord
	validates :name, presence: true
	validates :description, presence: true
	belongs_to :user
	validates :user_id, presence: true
	has_many :todo_owners
	has_many :owners, through: :todo_owners
	has_many :comments, dependent: :destroy

	has_one_attached :image
end