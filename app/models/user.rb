class User < ActiveRecord::Base
	has_secure_password

	attr_accessor :validate_password

	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :replys, dependent: :destroy

	has_attached_file :profile_picture, :styles => { :medium => "300x300>", :thumb => "100x100#" }
  	validates_attachment_content_type :profile_picture, content_type: /\Aimage\/.*\Z/

  	

	validates :registered_id, :presence => true, :uniqueness => true, :length => { :is => 10 }, 
	                                                                  :on => :create
	validates :first_name, :presence => true
	validates :last_name, :presence => true
	validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
	validates :password, :length => {:in => 6..20},  if: lambda { |u| u.validate_password == true }
end
