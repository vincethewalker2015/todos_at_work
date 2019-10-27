class TodoOwner < ApplicationRecord
  belongs_to :owner
  belongs_to :todo
end
