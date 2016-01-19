class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|

    	t.string :blocker_id
    	t.string :blockie_id

      t.timestamps null: false
    end
  end
end
