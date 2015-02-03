class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumbs, only: [:new, :create, :show, :edit, :update]

  def index
    @projects = Project.ordered.page(params[:page]).decorate
  end

  def new
    @project = Project.new
    add_create_breadcrumbs
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      add_create_breadcrumbs
      render :new
    end
  end

  def edit
    add_update_breadcrumbs
  end

  def show
    @issues = @project.issues.page(params[:page]).decorate
    add_breadcrumb @project.name
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      add_update_breadcrumbs
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  private

  def set_project
    @project = Project.find_by(id: params[:id])
    redirect_to(projects_url, alert: 'Could not find Project.') unless @project
  end

  def add_breadcrumbs
    add_breadcrumb :index, :projects_path
  end

  def add_create_breadcrumbs
    add_breadcrumb :new
  end

  def add_update_breadcrumbs
    add_breadcrumb @project.name_was, @project
    add_breadcrumb :edit
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
