class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :message
      t.integer :user_id
      t.integer :recipient_id

      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
