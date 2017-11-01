class UpdatesController < ApplicationController
  def create
    @updates = Update.all
    @update = Update.new(update_params)
    find_project
    @update.project = @project
    @update.user = current_user if current_user == @project.user
    if @update.save
      redirect_to project_path(@project)
    else
      flash[:alert] = "Only the Owner Can Create Updates!"
      render 'projects/show'
    end
  end

  def destroy
    find_project
    find_update
    @update.destroy
    redirect_to project_path(@project)
  end

  def edit
    find_update
    find_project
  end

  def update
    find_update
    find_project
    if @update.update(update_params)
      redirect_to project_path(@project)
    else
      redirect_back_or_to project_path(@project)
    end
  end

  private

  def update_params
    params.require(:update).permit(:description)
  end

  def find_update
    @update = Update.find(params[:id])
  end


end
