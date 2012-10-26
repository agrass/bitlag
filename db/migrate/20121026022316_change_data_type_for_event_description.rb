class ChangeDataTypeForEventDescription < ActiveRecord::Migration
  def up
     change_table :events do |t|
      t.change :description, :text, :limit => nil      
    end
  end

  def down
  end
end
