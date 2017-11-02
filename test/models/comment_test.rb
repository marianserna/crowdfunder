require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test 'comment can be created' do

    comment = create(:comment)
    assert comment.valid?

  end

  test 'text field cannot be empty' do
    comment = build(:comment, text: nil)
    refute comment.valid?
  end
end
