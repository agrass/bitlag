class CreateExpressions < ActiveRecord::Migration
  def change
    create_table :expressions do |t|
      t.references :tag
      t.string :expression

      t.timestamps
    end
    add_index :expressions, :tag_id
  end
end
