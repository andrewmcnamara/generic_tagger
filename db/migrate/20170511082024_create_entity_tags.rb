class CreateEntityTags < ActiveRecord::Migration[5.1]
  def change
    create_table :'entity_tags' do |t|
      t.references :entity, foreign_key: true
      t.references :tag, foreign_key: true
    end
  end
end
