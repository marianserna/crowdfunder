class ClaimsController < ApplicationController
  before_action :require_login
  before_action :load_project

  def create
    @claim = @project.claims.build
    @claim.project_id = params[:project][:id]
    @claim.user_id = current_user
    @claim.reward_id = params[:reward][:id]

    if @claim.save && @claim.uniq!
      redirect_to project_url(@project), notice: "You have successfully claimed #{@project.claims.description}!"
    else
      flash.now[:alert] = @claim.errors.full_messages.first
      render 'projects/show'
    end
  end

  private

  def load_project
    @project = Project.find(params[:project_id])
  end
end
