class ChangeDataTypeForEventPicture < ActiveRecord::Migration
  def up
     change_table :events do |t|
      t.change :picture, :text
      t.change :description, :text
    end
  end

  def down
     change_table :events do |t|
      t.change :picture, :string
      t.change :description, :string
    end
  end
end
