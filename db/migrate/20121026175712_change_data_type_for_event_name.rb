class ChangeDataTypeForEventName < ActiveRecord::Migration
  def up
      change_table :events do |t|
      t.change :name, :text, :limit => nil      
    end
  end

  def down
  end
end
