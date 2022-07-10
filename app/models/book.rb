class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def favorited_by?(current_user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.looks(searches, words)
    if searches == 'perfect'
      @book = Book.where("title LIKE ?", "#{words}")
    elsif searches == 'forward'
      @book = Book.where("title LIKE ?", "#{words}%")
    elsif searches == 'backward'
      @book = Book.where("title LIKE ?", "%#{words}")
    else
      @book = Book.where("title LIKE ?", "%#{words}%")
    end
  end  
end