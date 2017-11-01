class User < ActiveRecord::Base
  has_secure_password
  has_many :pledges
  has_many :projects
  has_many :pledge_projects, through: :pledges, source: :project
  has_many :comments
  has_many :updates


  validates :password, length: { minimum: 8 }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :email, uniqueness: true

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def total_pledged
    self.pledges.sum(:dollar_amount)
  end
end
