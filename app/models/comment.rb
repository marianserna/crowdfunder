class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :text, presence: true
  validate :user_has_pledged_project

  def user_has_pledged_project
    unless project.users.include?(user)
      errors.add(:base, "You can't make a comment if you haven't pledge to this project")
    end
  end
end
