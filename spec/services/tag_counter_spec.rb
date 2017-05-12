require "rails_helper"

RSpec.describe TagCounter do
  let(:tag) {Tag.create(name: "blue")}
  let!(:entity) {Entity.create(id: 1001, entity_type: "Product", tags: Array(tag))}

  specify "It counts the tags" do
    expect(TagCounter.new.count).to include({count: 1, tag: tag.name})

  end

end