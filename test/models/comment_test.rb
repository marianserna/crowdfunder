require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test 'comment can be created' do


    user = create(:user)
    project = create(:project)
    pledge = create(:pledge, user: user, project: project)
    comment = create(:comment, user: user, project: project)
    pledge = create(:pledge)
    comment = create(:comment, user: pledge.user, project: pledge.project)

    assert comment.valid?
  end

  test 'comment cannot be created' do

    user = create(:user)
    project = create(:project)
    comment = build(:comment, user: user, project: project)

    refute comment.valid?

  end

  test 'text field cannot be empty' do
    comment = build(:comment, text: nil)
    refute comment.valid?
  end


end
