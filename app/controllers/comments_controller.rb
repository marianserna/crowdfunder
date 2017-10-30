class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @project = Project.find(params[:project_id])
    @comment.project = @project
    @comment.user = current_user
    if @comment.save
      redirect_to project_path(@project)
    else
      render  'projects/show'
    end
  end

  def destroy
    find_comment
    @comment.destroy
  end

  def update
  end

  def edit
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

end
