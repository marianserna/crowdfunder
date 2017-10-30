require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test 'valid project can be created' do
    owner = create(:user)
    project = create(:project)
    project.user = owner

    assert project.valid?
    assert project.persisted?
    assert project.user
  end

  test 'project is invalid without owner' do
    project = build(:project)
    project.user = nil
    project.save

    assert project.invalid?, 'Project should not save without owner.'
  end

  test 'project start date is in future' do
    user = create(:user)
    project = build(:project)
    project.user_id = user.id
    project.start_date = Date.yesterday
    project.save

    assert project.invalid?, 'Start date must be in the future'
  end

  test 'project end date must be later than start date' do
    user = create(:user)
    project = build(:project)
    project.user_id = user.id
    project.end_date = Date.yesterday
    project.save

    assert project.invalid?, 'End date must be later'
  end

  test 'goal is a positive number' do
    user = create(:user)
    project = build(:project)
    project.user_id = user.id
    project.goal = -3000
    project.save

    assert project.invalid?, 'Goal must be a positive number'
  end

  test 'total pledged in project' do
    user1 = create(:user)
    user2 = create(:user, first_name: "Daniel", last_name: "Lopez", email: "daniel@email.com", password: "password", password_confirmation: "password")

    project1 = create(
      :project,
      title: 'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.tomorrow,
      end_date:    Date.tomorrow + 1.month,
      goal:        50000,
      user:        user1
    )

    assert_equal project1.total_pledged_in_project, 0

    pledge = create(
      :pledge,
      dollar_amount:  99.00,
      project:        project1,
      user:           user2
    )

    assert_equal project1.total_pledged_in_project, 99.00
  end

  # test 'current user have not backed up this project' do
  #
  # end
end
