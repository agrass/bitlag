class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name      
      t.float :longitude
      t.float :latitude
      t.boolean :gmaps
      t.string :description
      t.timestamp :start_time
      t.timestamp :end_time
      t.string :address
      t.integer :fb_id, :limit => 8
      t.integer :owner_id, :limit => 8
      t.string :city
      t.string :country
      t.string :picture
      t.integer :atenders
      t.string :privacy
      t.timestamps
      
     
    end
  end
end
