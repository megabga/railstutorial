# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(25)
#  email      :string(100)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  
  before_save { |user| user.email = email.downcase }
  
  #BASICS
  VALID_NAME_REGEX = /\A\w+\s\w+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,  presence: true, length: { maximum: 30 }, format: { with: VALID_NAME_REGEX }, uniqueness: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false } #:email => true
  
  #PASSWORD
  has_secure_password
  
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  
end
