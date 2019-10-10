class UserCommunity < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :community, dependent: :destroy
end
