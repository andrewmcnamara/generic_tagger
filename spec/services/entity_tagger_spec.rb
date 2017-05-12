require "rails_helper"

RSpec.describe EntityTagger do
  let(:entity_id) {1000}
  let(:entity_params) do
    {id: entity_id,
     type: "Book",
     tags: ["pink", "handle"]}
  end

  context "When entity exists" do
    let(:tag) {Tag.create(name: "blue")}
    let!(:existing_entity) {Entity.create(id: entity_id, entity_type: "Product", tags: Array(tag))}

    specify "It updates the product type" do
      EntityTagger.new(entity_params).tag
      expect(existing_entity.reload.entity_type).to eq(entity_params[:type])
    end

    specify "It replaces the tags" do
      EntityTagger.new(entity_params).tag
      expect(existing_entity.reload.tags.map(&:name)).to contain_exactly("pink", "handle")
    end
  end

  context "When entity does not exist" do
    let(:created_entity) {Entity.find(entity_id)}

    specify "It sets the product type" do
      EntityTagger.new(entity_params).tag
      expect(created_entity.entity_type).to eq(entity_params[:type])
    end

    specify "It sets the tags" do
      EntityTagger.new(entity_params).tag
      expect(created_entity.tags.map(&:name)).to contain_exactly("pink", "handle")
    end

    context "When tag does not exist" do
      specify "It creates a new tag" do
        expect {EntityTagger.new(entity_params).tag}.to change {Tag.count}.by(entity_params[:tags].length)
      end
    end

    context "When tag exists" do
      before do
        Tag.create(name: "pink")
        Tag.create(name: "handle")
      end
      specify "It does not create a new tag" do
        expect {EntityTagger.new(entity_params).tag}.not_to change {Tag.count}
      end
    end
  end
end