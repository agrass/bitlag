class ChangeDataTypeForEventPicture < ActiveRecord::Migration
  def up
    change_table :events do |t|
      t.change :picture, :text, :limit => nil
      
    end
    
  end

  def down
  end
end
