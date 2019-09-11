class User < ApplicationRecord
  validates :name, presence: true
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    has_secure_password
  validates :password, presence: true, length: {minimum: 6}
  has_many :articles
  has_many :comments

  #一人のユーザーには1対多のリレーションシップがある。
  #この関係はフォローする側(active_relationships),フォローされる側(passive_relationships)の2つの視点がUserモデルに属する
  has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #能動的関係を通して、ユーザーがフォローしているユーザーの集合を集める
  has_many :following, through: :active_relationships, source: :followed
  #受動的関係を通して、ユーザーがフォローされているユーザーの集合を集める
  has_many :followers, through: :passive_relationships

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
end
