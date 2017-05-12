class StatsController < ApplicationController
  def index
    tag_counts = TagCounter.new.count
    render json: tag_counts.as_json
  end
end
