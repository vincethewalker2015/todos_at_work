class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true

    has_many :todos, dependent: :destroy
    has_secure_password
    has_many :comments, dependent: :destroy
    has_many :messages, dependent: :destroy
end
