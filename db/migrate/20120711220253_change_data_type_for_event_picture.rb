class ChangeDataTypeForEventPicture < ActiveRecord::Migration
  def up
     change_table :events do |t|
      t.change :picture, :text
      
    end
  end

  def down
     change_table :events do |t|
      t.change :picture, :string      
    end
  end
end
