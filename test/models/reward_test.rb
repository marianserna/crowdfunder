require 'test_helper'

class RewardTest < ActiveSupport::TestCase

  test 'A reward can be created' do
    project = new_project
    project.save
    reward = Reward.create(
      dollar_amount: 99.00,
      description: 'A heartfelt thanks!',
      project: project
    )
    assert reward.valid?
    assert reward.persisted?
  end

  test 'A reward cannot be created without a dollar amount' do
    project = new_project
    project.save
    reward = Reward.create(
      description: 'A heartfelt thanks!',
      project: project
    )
    assert reward.invalid?, 'Reward should be invalid without dollar amount'
    assert reward.new_record?, 'Reward should not save without dollar amount'
  end

  test 'A reward cannot be created without a description' do
    project = new_project
    project.save
    reward = Reward.create(
      dollar_amount: 99.00,
      project: project
    )
    assert reward.invalid?, 'Reward should be invalid without a description'
    assert reward.new_record?, 'Reward should not save without a description'
  end

  def new_project
    Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.tomorrow,
      end_date:    Date.tomorrow + 1.month,
      goal:        50000
    )
  end

  def new_user
    User.new(
      first_name:            'Sally',
      last_name:             'Lowenthal',
      email:                 'sally@example.com',
      password:              'passpass',
      password_confirmation: 'passpass'
    )
  end

  test 'Reward dollar amount must be a positive number' do
    user = new_user
    user.save!
    project = new_project
    project.user = user
    project.save!
    reward = Reward.create(
      dollar_amount: -500,
      project: project
    )
    assert reward.invalid?, 'Reward dollar amount must be a positive number'
  end
end
