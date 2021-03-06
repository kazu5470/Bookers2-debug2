class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy  
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}

  #フォローした、された
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy 
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #一覧画面表示
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  #フォローした
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end  
  #フォロー外す
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  
  #フォローしているかどうか
  def following?(user)
    followings.include?(user)
  end  
  
  #検索方法分岐条件
  def self.looks(searches, words)
    if searches == 'perfect'
      @user = User.where("name LIKE ?", "#{words}")
    elsif searches == 'forward'
      @user = User.where("name LIKE ?", "#{words}%")
    elsif searches == 'backward'
      @user = User.where("name LIKE ?", "%#{words}")
    else
      @user = User.where("name LIKE ?", "%#{words}%")
    end
  end  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
