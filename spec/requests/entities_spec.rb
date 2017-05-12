require "rails_helper"

RSpec.describe "Entity management", type: :request do


  describe "Retrieving a specific entity" do
    let(:entity_id) {100}
    context "When entity exists" do
      let(:pink_tag) {Tag.create(name: "Pink")}
      let(:bike_tag) {Tag.create(name: "Bike")}
      let!(:entity) {Entity.create(id: entity_id, entity_type: "Product", tags: [pink_tag, bike_tag])}

      let(:entity_response) {JSON.parse(response.body)}

      specify do
        get "/entities/#{entity_id}"
        expect(response).to have_http_status(:ok)
      end

      specify "It includes the product type in the response" do
        get "/entities/#{entity_id}"
        expect(entity_response).to include({"type" => entity.entity_type})
      end

      specify "It includes the tags in the response" do
        get "/entities/#{entity_id}"
        expect(entity_response).to include({"tags" => ["Pink", "Bike"]})
      end
    end

    context "When entity does not exist" do
      specify do
        get "/entities/#{entity_id}"
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "Tagging an entity" do
    let(:entity_params) do
      {id: 1001,
       type: "Book",
       tags: ["pink", "handle"]}
    end

    context "When entity has already not been tagged" do
      specify "It creates a new entity" do
        expect {post "/tag/", params: {entity: entity_params}}.to change {Entity.count}.by(1)
        expect(response).to have_http_status(:ok)
      end
    end

    context "When entity has already been tagged" do
      let!(:existing_entity) {Entity.create(id: entity_params[:id], entity_type: "Product")}

      specify "It updates the existing entity" do
        expect {post "/tag/", params: {entity: entity_params}}.not_to change {Entity.count}
        expect(response).to have_http_status(:ok)
        expect(existing_entity.reload.entity_type).to eq(entity_params[:type])
      end
    end
  end
end