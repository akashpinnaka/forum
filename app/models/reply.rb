class Reply < ActiveRecord::Base

	belongs_to :comment
	belongs_to :user

	validates :content, :presence => true

end
