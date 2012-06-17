class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fb_id
      t.string :access_token
      t.boolean :scaned
      t.timestamps
    end
  end
end
