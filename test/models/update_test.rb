require 'test_helper'

class UpdateTest < ActiveSupport::TestCase

test "An update can not be created without user_id" do
  user = create(:user)
  project = create(:project, user: user)
  update = build(:update, project: project)

  assert_equal false, update.valid?
end

test "An update can not be created without project_id" do
  user = create(:user)
  update = build(:update, user: user)

  assert_equal false, update.valid?
end

test "An updated can not be created if you are not the project owner" do
  user1 = create(:user, admin: true)
  user2 = create(:user, admin: false)

  project = create(:project, user: user1)
  update = build(:update, user: user2, project: project)

  assert_equal false, update.valid?
end


end
