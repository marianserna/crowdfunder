require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "email must be unique" do
    user = User.create(email: "bettymaker@gmail.com", password: "12345678", password_confirmation: "12345678")
    user2 = User.new(email: "bettymaker@gmail.com", password: "00000000", password_confirmation: "00000000")
    refute user2.valid?
  end

  test "user must include password_confirmation on create" do
    user = User.new(email: "bettymaker@gmail.com", password: "12345678")
    refute user.valid?
  end

  test "password must match confirmation" do
    user = User.new(email: "bettymaker@gmail.com", password: "12345678", password_confirmation: "87654321")
    refute user.valid?
  end

  test "password must be at least 8 characters long" do
    user = User.new(email: "bettymaker@gmail.com", password: "1234", password_confirmation: "1234")
    refute user.valid?
  end

  test 'name' do
    user = User.new(first_name: "Pablo", last_name: "Perez")
    assert user.name == "Pablo Perez", "User name doesn't contain first and last name"
  end

  test 'total_pledged' do
    user1 = User.create!(first_name: "Pablo", last_name: "Perez", email: "pablo@email.com", password: "password", password_confirmation: "password")

    user2 = User.create!(first_name: "Daniel", last_name: "Lopez", email: "daniel@email.com", password: "password", password_confirmation: "password")

    project1 = Project.create!(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.tomorrow,
      end_date:    Date.tomorrow + 1.month,
      goal:        50000,
      user:        user1
    )

    pledge = Pledge.create!(
      dollar_amount:  99.00,
      project:        project1,
      user:           user2
    )

    assert_equal user2.total_pledged, 99.00
    assert_equal user1.total_pledged, 0
  end
end
