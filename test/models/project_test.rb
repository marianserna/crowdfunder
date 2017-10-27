require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test 'valid project can be created' do
    owner = new_user
    owner.save
    project = new_project
    project.user = owner
    project.save
    assert project.valid?
    assert project.persisted?
    assert project.user
  end

  test 'project is invalid without owner' do
    project = new_project
    project.user = nil
    project.save
    assert project.invalid?, 'Project should not save without owner.'
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

  test 'project start date is in future' do
    user = new_user
    user.save!
    project = new_project
    project.user_id = user.id
    project.start_date = Date.yesterday
    project.save
    assert project.invalid?, 'Start date must be in the future'
  end

  test 'project end date must be later than start date' do
    user = new_user
    user.save!
    project = new_project
    project.user_id = user.id
    project.end_date = Date.yesterday
    project.save
    assert project.invalid?, 'End date must be later'
  end

  test 'goal is a positive number' do
    user = new_user
    user.save!
    project = new_project
    project.user_id = user.id
    project.goal = -3000
    project.save
    assert project.invalid?, 'Goal must be a positive number'
  end
end
