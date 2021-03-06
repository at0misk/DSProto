class User < ActiveRecord::Base
	has_secure_password
	has_many :carts
	has_many :creds
	email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :first, :last, :email, :password, presence: true
	validates :email, :uniqueness => true, :format => { :with => email_regex }
	validates_uniqueness_of :email, :case_sensitive => false
end
