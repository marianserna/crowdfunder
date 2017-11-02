class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  has_many :updates
  belongs_to :user # project owner
  belongs_to :category
  has_many :claims

  has_many :comments
  validates :title, :user_id, :description, :goal, :start_date, :end_date, presence: true
  validates :goal, numericality: { greater_than_or_equal_to: 0 }

  validate :start_date_must_be_future
  validate :end_date_later_than_start_date

  scope :active, -> { where("current_date between start_date and end_date" ) }
  scope :inactive, -> { where('end_date < ?', Date.today) }

  def start_date_must_be_future
    return unless start_date
    if start_date < Date.today
      errors.add(:start_date, 'Must be in the future')
    end
  end

  def end_date_later_than_start_date
    return unless end_date && start_date
    if end_date < start_date
      errors.add(:end_date, 'Must be later than start date')
    end
  end

  def total_pledged_in_project
    self.pledges.sum(:dollar_amount)
  end

  def backed_up?(current_user)
    return self.users.include?(current_user)
  end

  def remaining_time
    ((self.end_date.end_of_day.utc > Time.now.utc) ? 'remaining' : 'past deadline').to_s
  end

end
