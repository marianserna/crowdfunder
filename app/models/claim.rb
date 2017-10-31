class Claim < ApplicationRecord
  belongs_to :reward
  belongs_to :user
  belongs_to :project
  # this is wrong
  # has_many :rewards
  # has_many :users
  # has_many :projects

  validates :project_id, :reward_id, :user_id, presence: true
end
