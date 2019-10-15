class User < ApplicationRecord
  validates :name, presence: true, unless: :uid?
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, unless: :uid?
  validates :password, presence: true, length: {minimum: 6}, unless: :uid?
  validates :img, presence: true
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorites_articles, through: :favorites, source: :article
  has_many :communities, dependent: :destroy
  has_many :user_communities, dependent: :destroy
  has_many :join_communities, through: :user_communities, source: :community
  has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships
  mount_uploader :img, ImgUploader
  has_secure_password

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

  #auth hashからユーザー情報取得
  #DBにユーザーが存在すれば情報取得し更新、存在しなければユーザー作成
  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    image = auth[:info][:image]

    #DB情報更新
    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
      user.img = image
    end
  end

  #ユーザー検索
  def self.search(search)
    if search
      User.where(['name LIKE ?', "%#{search}%"])
    else
      User.all
    end
  end
end
