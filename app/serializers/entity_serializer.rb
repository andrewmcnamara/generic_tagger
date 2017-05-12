class EntitySerializer < ActiveModel::Serializer
  attributes :id, :tags, :type

  def tags
    object.tags.map(&:name)
  end

  def type
    object.entity_type
  end
end
