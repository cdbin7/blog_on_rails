class Post < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true, length: {minimum: 50}


  has_many :comments, dependent: :destroy

  before_save :titleize_title
  
  private

  def titleize_title
    self.title = self.title.titlecase
  end
end
