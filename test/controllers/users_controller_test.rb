require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def login(user)
    user = create(:user)
    post user_sessions_url, params: { email: user.email, password: "password" }
  end

  test "should show user" do
    # login(@user)
    user = create(:user)
    get user_url(user)

    assert_response :success
  end
end
