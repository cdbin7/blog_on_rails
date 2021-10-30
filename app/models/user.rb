class User < ApplicationRecord
  has_secure_password

  validates :name, :email, presence: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy


  
  validates :password, presence: true, :on => :create
  


end
