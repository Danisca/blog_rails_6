class User < ApplicationRecord
	before_save { self.email = email.downcase}
	has_many :articles
	validates :username, presence: true, uniqueness: {case_sensitive: false}, 
						length: {minimum: 3, maximum: 25} 
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
# VALID_EMAIL_REGEX contains the regular expresion to validate if the email 
#passed is a valid email or not
	validates :email, presence: true, uniqueness: true, 
						length: {minimum: 3, maximum: 125},
						format:  {with: VALID_EMAIL_REGEX}
	has_secure_password
end