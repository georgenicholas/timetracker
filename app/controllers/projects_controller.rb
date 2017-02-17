class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def create
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to projects_path, notice: "Project created!"
    else
      render :new
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :client, :archived)
  end
end
