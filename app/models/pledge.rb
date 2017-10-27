class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :dollar_amount, presence: true
  validates :user, presence: true
  validate :owner_cannot_back_own_project

  def owner_cannot_back_own_project
    if self.user == self.project.user
      errors.add(:user, 'Owner cannot pledge to their project')
    end
  end
end
