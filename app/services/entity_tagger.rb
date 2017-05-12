class EntityTagger

  def initialize(entity_params)
    @entity_params = entity_params
  end

  def tag
    entity.update(entity_type: @entity_params[:type], tags: build_tags)
    entity
  end

  private
  def build_tags
    @tags ||= Array(@entity_params[:tags]).map {|tag_name| Tag.find_or_create_by(name: tag_name)}
  end

  def entity
    @entity ||= Entity.find_or_initialize_by(id: @entity_params[:id])
  end
end