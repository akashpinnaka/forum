class AddCommentIdToReply < ActiveRecord::Migration
  def change
    add_column :replies, :comment_id, :string
  end
end
