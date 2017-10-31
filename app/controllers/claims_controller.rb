class ClaimsController < ApplicationController
  before_action :require_login
  before_action :load_project
  before_action :load_reward

  def create
    # raise params.inspect
    @claim = Claim.new
    @claim.project_id = @project.id
    @claim.user_id = current_user.id
    @claim.reward_id = @reward.id

    # need to add a condition that checks the amount being claimed matches the amount pleged by the user
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
    # Cant load a reward using the id of the project. You're finding a random reward with the same id as the project
    # @reward = Reward.find(params[:project_id])
    @reward = Reward.find(params[:claim][:reward_id])
  end

  # never called
  # def load_pledge
  #   @pledge = Pledge.find(params[:project_id])
  # end

  private

  def pledged_total_per_user
    # you should only search the pledges FOR THE CURRENT PROJECT
    # Pledge.select([:user_id, :project_id]).where({ user_id: @claim.user_id }).sum(:dollar_amount)
    @project.pledges.where(user_id: @claim.user_id).sum(:dollar_amount)
  end

  # You don't need this unless you're using it in the view
  # helper_method :pledged_total_per_user

  def already_claimed?
    Claim.where(user_id: @claim.user_id).where(project_id: @claim.project_id).where(reward_id: @claim.reward_id).count > 0
  end

  # You don't need this unless you're using it in the view
  # helper_method :already_claimed?
end
