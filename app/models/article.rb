class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :img, presence: true
  mount_uploader :img, ImgUploader
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  belongs_to :tag
  belongs_to :user

  #記事にいいねする
  def favorite(user)
    favorites.create(user_id: user.id)
  end

  #記事のいいねを解除する
  def remove_favorite(user)
    favorites.find_by(user_id: user.id).destroy
  end

  #現在のユーザーがいいねしていたらtrueを返す
  def favorite?(user)
    favorite_users.include?(user)
  end

  #記事検索
  def self.search(search)
    if search
      Article.where(['title LIKE ?', "%#{search}%"])
    else
      Article.all
    end
  end
end
