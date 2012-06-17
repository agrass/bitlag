class CreateEventsTags < ActiveRecord::Migration
  def change
    create_table :events_tags, :id => false do |t|
      t.references :event, :tag
    end
    add_index :events_tags, [:event_id, :tag_id]
  end
end
