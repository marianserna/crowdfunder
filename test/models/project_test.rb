require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  # test 'valid project can be created' do
  #   owner = new_user
  #   owner.save
  #   project = new_project
  #   project.user = owner
  #   project.save
  #   assert project.valid?
  #   assert project.persisted?
  #   assert project.user
  # end
  #
  # test 'project is invalid without owner' do
  #   project = new_project
  #   project.user = nil
  #   project.save
  #   assert project.invalid?, 'Project should not save without owner.'
  # end

  # def new_project
  #   Project.new(
  #     title:       'Cool new boardgame',
  #     description: 'Trade sheep',
  #     start_date:  Date.tomorrow,
  #     end_date:    Date.tomorrow + 1.month,
  #     goal:        50000
  #   )
  # end
  #
  # def new_user
  #   User.new(
  #     first_name:            'Sally',
  #     last_name:             'Lowenthal',
  #     email:                 'sally@example.com',
  #     password:              'passpass',
  #     password_confirmation: 'passpass'
  #   )
  # end
  #
  #
  # test 'project start date is in future' do
  #   user = new_user
  #   user.save!
  #   project = new_project
  #   project.user_id = user.id
  #   project.start_date = Date.yesterday
  #   project.save
  #   assert project.invalid?, 'Start date must be in the future'
  # end
  #
  # test 'project end date must be later than start date' do
  #   user = new_user
  #   user.save!
  #   project = new_project
  #   project.user_id = user.id
  #   project.end_date = Date.yesterday
  #   project.save
  #   assert project.invalid?, 'End date must be later'
  # end
  #
  # test 'goal is a positive number' do
  #   user = new_user
  #   user.save!
  #   project = new_project
  #   project.user_id = user.id
  #   project.goal = -3000
  #   project.save
  #   assert project.invalid?, 'Goal must be a positive number'
  # end
  #
  # test 'total pledged in project' do
  #   user1 = User.create!(first_name: "Pablo", last_name: "Perez", email: "pablo@email.com", password: "password", password_confirmation: "password")
  #
  #   user2 = User.create!(first_name: "Daniel", last_name: "Lopez", email: "daniel@email.com", password: "password", password_confirmation: "password")
  #
  #   project1 = Project.create!(
  #     title:       'Cool new boardgame',
  #     description: 'Trade sheep',
  #     start_date:  Date.tomorrow,
  #     end_date:    Date.tomorrow + 1.month,
  #     goal:        50000,
  #     user:        user1
  #   )
  #
  #   assert_equal project1.total_pledged_in_project, 0
  #
  #   pledge = Pledge.create!(
  #     dollar_amount:  99.00,
  #     project:        project1,
  #     user:           user2
  #   )
  #
  #   assert_equal project1.total_pledged_in_project, 99.00
  # end

  test 'current user have not backed up this project' do
   current_user = create(:user, admin: false)
   owner_user = create(:user)
   pledge_user = create(:user, admin: false)

   project = create(:project, user: owner_user)
   pledge = create(:pledge, user: pledge_user, project: project)

   result = project.backed_up?(current_user)

   assert_equal(false, result)
  end


  test 'current user have backed up this project' do
   current_user = create(:user, admin: false)
   owner_user = create(:user)

   project = create(:project, user: owner_user)
   pledge = create(:pledge, user: current_user, project: project)
   result = project.backed_up?(current_user)

  #  binding.pry
   assert_equal(true, result)
  end

  test "display project time remaining" do
    project = create(:project, end_date: (DateTime.current + 1.day))

    expect = 'remaining'
    result = project.remaining_time

    assert_equal(expect, result)
  end

  test "display project time past due" do
    project = build(:project, end_date: (DateTime.current - 1.day), start_date: (DateTime.current - 2.day))

    expect = 'past deadline'
    result = project.remaining_time

    assert_equal(expect, result)
  end
end
