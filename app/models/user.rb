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
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  #attr_readonly :admin
  attr_accessible :name, :email, :password, :password_confirmation, :admin

  has_secure_password
  has_many :microposts, dependent: :destroy
  
  #BASICS
  VALID_NAME_REGEX = /\A\w+.*\s.*\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,  presence: true, length: { maximum: 30 }, format: { with: VALID_NAME_REGEX }, uniqueness: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false } #:email => true
  
  #PASSWORD  
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  public
  
    def feed
      # This is preliminary. See "Following users" for the full implementation.
      Micropost.where("user_id = ?", id)
    end
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
  
  
end
