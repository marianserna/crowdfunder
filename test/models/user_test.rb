require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "email must be unique" do
    user = create(:user)
    user2 = build(:user, email: user.email)
    refute user2.valid?
  end

  test "user must include password_confirmation on create" do
    user = build(:user, password_confirmation: nil)
    refute user.valid?
  end

  test "password must match confirmation" do
    user = build(:user, password: "12345678", password_confirmation: "87654321")
    refute user.valid?
  end

  test "password must be at least 8 characters long" do
    user = build(:user, password: "1234", password_confirmation: "1234")
    refute user.valid?
  end

  test 'name' do
    user = build(:user)
    assert user.name == "Pablo Perez", "User name doesn't contain first and last name"
  end

  test 'total_pledged' do
    user1 = create(:user)

    user2 = create(:user)

    project1 = create(:project, start_date: Date.tomorrow, end_date: Date.tomorrow + 1.month, user: user1)

    pledge = create(:pledge, dollar_amount:  99.00, project: project1, user: user2)

    assert_equal user2.total_pledged, 99.00
    assert_equal user1.total_pledged, 0
  end
end
