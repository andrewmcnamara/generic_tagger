class Tag < ApplicationRecord
  has_many :entity_tags
  has_many :entities, through: :entity_tags
end
