class HomeController < ApplicationController

  def show
    @hide_home_link = true
    @dark_theme = true
    @total_projects = Project.count
    @total_pledged = Pledge.sum(:dollar_amount)
    @projects_funded = Project.
      joins(:pledges).
      group(:id).
      having('sum(pledges.dollar_amount) >= projects.goal').
      length
  end
end
