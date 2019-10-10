class Community < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :explanation, presence: true

  has_many :user_communities, dependent: :destroy
  has_many :join_users, through: :user_communities, source: :user
  belongs_to :user

  #現在のユーザーがcommunityに参加済だったらtrueを返す
  def community_join?(user)
    join_users.include?(user)
  end
end
