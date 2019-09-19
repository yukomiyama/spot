class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :favorite, dependent: :destroy
  has_many :favorite_users, through: :favorite, source: :user
  belongs_to :tag
  belongs_to :user

  #記事にいいねする
  def favorite(user)
    Favorite.create(user_id: user.id)
  end

  #記事のいいねを解除する
  def remove_favorite(user)
    Favorite.find_by(user_id: user.id).destroy
  end

  #現在のユーザーがいいねしていたらtrueを返す
  def favorite?(user)
    favorite_users.include?(user)
  end
end
