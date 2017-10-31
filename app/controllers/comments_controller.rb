class CommentsController < ApplicationController
  def create
    @comments = Comment.all
    @comment = Comment.create(comment_params)
    find_project
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
    find_project
    @comment.destroy
    redirect_to project_path(@project)
  end


  def update
    find_comment
    find_project
    if @comment.update(comment_params)
    redirect_to project_path(@project)
    else
      redirect_back_or_to project_path(@project)
    end
  end

  def edit
    find_comment
    find_project
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

end
