require "rails_helper"

RSpec.describe "Tag stats", type: :request do

  describe "Retrieving stats for all tags" do
    let(:tag) {Tag.create(name: "blue")}
    let!(:existing_entity) {Entity.create(id: 1001, entity_type: "Product", tags: Array(tag))}

    specify "It returns the stats for all tags" do
      get "/stats/"
      expect(response).to have_http_status(:ok)
      tag_stats = JSON.parse(response.body)
      expect(tag_stats).to include({"count" => 1, "tag" => tag.name})
    end
  end
end