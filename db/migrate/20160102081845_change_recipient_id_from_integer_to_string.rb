class ChangeRecipientIdFromIntegerToString < ActiveRecord::Migration
  def change
  	change_column :notifications, :recipient_id, :string
  end
end
