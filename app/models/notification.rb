class Notification < ActiveRecord::Base
	belongs_to :user

	def self.read_all
	   Notification.all.update_all(status: true)
	end

end
