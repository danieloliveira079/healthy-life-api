class User < ActiveRecord::Base
  has_many :authentication_tokens
  has_many :campaign
  
  has_secure_password
  validates :password, length: { minimum: 8 }
end
