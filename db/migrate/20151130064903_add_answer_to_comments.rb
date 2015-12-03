class AddAnswerToComments < ActiveRecord::Migration
  def change
    add_column :comments, :answer, :text
  end
end
