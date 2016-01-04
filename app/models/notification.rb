class Notification < ActiveRecord::Base
	belongs_to :user

	validates :message, :presence => true
	validates :recipient_id, :presence => true

	def self.read_all
	   Notification.all.update_all(status: true)
	end

end
