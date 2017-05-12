class EntityTag < ApplicationRecord
  belongs_to :entity
  belongs_to :tag
end