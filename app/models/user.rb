class User < ActiveRecord::Base
	has_secure_password

	attr_accessor :validate_password

	has_many :posts, dependent: :destroy

	validates :registered_id, :presence => true, :uniqueness => true, :length => { :is => 10 }, :on => :create
	validates :first_name, :presence => true
	validates :last_name, :presence => true
	validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
	validates :password, :length => {:in => 6..20},  if: lambda { |u| u.validate_password == true }
end
