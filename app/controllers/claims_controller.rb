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
    if pledged_total_per_user < @reward.dollar_amount

      flash.now[:alert] = "Sorry but you have do not have enough pledged to claimed this reward"
      render 'projects/show'

    elsif already_claimed?
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

  def load_pledge
    @pledge = Pledge.find(params[:project_id])
  end

  private

  def pledged_total_per_user
    Pledge.select([:user_id, :project_id]).where({ user_id: @claim.user_id }).sum(:dollar_amount)
  end
  helper_method :pledged_total_per_user

  def already_claimed?
    Claim.where(user_id: @claim.user_id).where(project_id: @claim.project_id).where(reward_id: @claim.reward_id).count > 0
  end
  helper_method :already_claimed?

end
