class Claim < ApplicationRecord
  belongs_to :reward
  belongs_to :user
  belongs_to :project

  validates :project_id, :reward_id, :user_id, presence: true
end
