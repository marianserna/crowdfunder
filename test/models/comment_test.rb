require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test 'comment can be created' do
    pledge = create(:pledge)
    comment = create(:comment, user: pledge.user, project: pledge.project)
    assert comment.valid?
  end

  test 'text field cannot be empty' do
    comment = build(:comment, text: nil)
    refute comment.valid?
  end
end
