class CreateUsersEvents < ActiveRecord::Migration
  def change
    create_table :users_events do |t|
      t.references :user
      t.references :event

      t.timestamps
    end
    add_index :users_events, :user_id
    add_index :users_events, :event_id
  end
end
