class Post < ActiveRecord::Base

	acts_as_votable

	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :replys, dependent: :destroy
	
end
