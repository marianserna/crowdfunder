class ClaimsController < ApplicationController
  before_action :require_login
  before_action :load_project
  before_action :load_reward

  def create
    @claim = Claim.new
    @claim.project_id = @project.id
    @claim.user_id = current_user.id
    @claim.reward_id = @reward.id

    # need to add a condition that checks the amount being claims matches the amount pleged by the user
    if Claim.where(user_id: @claim.user_id).where(project_id: @claim.project_id).where(reward_id: @claim.reward_id).count > 0
      flash.now[:alert] = "Sorry but you have already claimed this reward"
      render 'projects/show'

    elsif @claim.save
      redirect_to project_url(@project), notice: "You have successfully claimed your reward!"
    else
      flash.now[:alert] = @claim.errors.full_messages.first
      render 'projects/show'
    end
  end

  private

  def load_project
    @project = Project.find(params[:project_id])
  end

  def load_reward
    @reward = Reward.find(params[:project_id])
  end

end
