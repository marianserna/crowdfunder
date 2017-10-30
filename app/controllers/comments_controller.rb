class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to
      comment_path(@comment)
    else
      render projects_path
    end
  end

  def destroy
  end

  def update
  end

  def edit
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :user_id, :project_id)
  end

end
