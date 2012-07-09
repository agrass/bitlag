class RemoveColumnTags < ActiveRecord::Migration
  def change
     remove_column :tags, :expression
  end
end
