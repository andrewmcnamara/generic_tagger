class TagCounter
  def count
    Tag.joins(:entities).group("tags.name").count.map do |(tag_name, count)|
      {tag: tag_name, count: count}
    end
  end
end