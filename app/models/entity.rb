class Entity < ApplicationRecord
  has_many :entity_tags
  has_many :tags, through: :entity_tags, dependent: :destroy
end
