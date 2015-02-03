class IssuesController < ApplicationController
  before_action :set_project, only: [:new, :create]
  before_filter :set_issue, only: [:show, :edit, :update, :destroy, :close, :open]
  before_action :add_breadcrumbs

  def new
    @issue = @project.issues.build
    add_create_breadcrumbs
  end

  def create
    @issue = @project.issues.build(issue_params)

    if @issue.save
      redirect_to @issue, notice: 'Issue was successfully created.'
    else
      add_create_breadcrumbs
      render :new
    end
  end

  def edit
    add_update_breadcrumbs
  end

  def show
    @issue = @issue
    add_breadcrumb @ssue.title
  end

  def update
    if @issue.update(issue_params)
      redirect_to @issue, notice: 'Issue was successfully updated.'
    else
      add_update_breadcrumbs
      render :edit
    end
  end

  def destroy
    @issue.destroy
    redirect_to @issue.project, notice: 'Issue was successfully destroyed.'
  end

  def close
    @issue.closed!
    render :update
  end

  def open
    @issue.open!
    render :update
  end

  private

  def set_project
    @project = Project.find_by(id: params[:project_id])
    redirect_to(projects_url, alert: 'Could not find Project.') unless @project
  end

  def set_issue
    @issue = Issue.find_by(id: params[:id])

    if @issue
      @issue = @issue.decorate
    else
      redirect_to(root_url, alert: 'Could not find Issue.') unless @issue
    end
  end

  def add_breadcrumbs
    project = @project || @issue.project
    add_breadcrumb :index, :projects_path
    add_breadcrumb project.name, project
  end

  def add_create_breadcrumbs
    add_breadcrumb :new
  end

  def add_update_breadcrumbs
    add_breadcrumb @issue.title_was, @issue
    add_breadcrumb :edit
  end

  def issue_params
    params.require(:issue).permit(:title, :description)
  end
end
