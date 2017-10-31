require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  comment = new_comment

  comment = new_comment
  comment.save
  assert comment.valid?



  def new_comment
    Comment.new(
      text: hello
    )
  end




end
