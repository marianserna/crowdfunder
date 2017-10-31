class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
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
    @comment = Comment.find(params[:project_id])
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


end
