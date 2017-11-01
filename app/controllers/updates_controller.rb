class UpdatesController < ApplicationController
  def create
    @updates = Update.all
    @update = Update.create(update_params)
    find_project
    @update.project = @project
    @update.user = current_user
    if @update.save
      redirect_to project_path(@project)
    else
      render 'projects/show'
    end
  end

  def destroy
    find_update
    @update.destrot
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
    params.require(:update).permit(:descripton)
  end

  def find_project
    @project = Project.find(params[:id])
  end

  def find_update
    @update = Update.find(params[:id])
  end


end
