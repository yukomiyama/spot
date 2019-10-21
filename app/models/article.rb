class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  # validates :img, presence: true
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many_attached :imgs
  # mount_uploader :img, ImgUploader
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

  #記事検索(検索範囲:tag、記事本文、記事見出し)
  #複数ワード検索機能追加(ex.. "ruby rails")
  def self.search(keyword)
    if keyword && keyword != ""

      #検索キーワード
      keywords = keyword.to_s.split(" ")
      #検索対象のカラム
      columns = ["content", "title", "name"]
      #検索対象のカラム分のクエリ発行
      querys = columns.map {|column| "#{column} LIKE ?" }
      #検索結果
      results = []

      keywords.each_with_index do |keyword, index|
        if index == 0
          results[index] = Article.joins(:tag).where(querys.join(" OR "), "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
        else
          results[index] = results[index-1].where(querys.join(" OR "), "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
        end
      end

      return results[keywords.length-1]
    else
      Article.all
    end

    # Article.joins(:tag).where("content LIKE ? OR title LIKE ? OR name LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end
end
