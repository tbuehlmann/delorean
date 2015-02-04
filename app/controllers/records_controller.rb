class RecordsController < ApplicationController
  before_action :set_issue, only: [:new, :create]
  before_filter :set_record, only: [:edit, :update, :destroy]
  before_action :add_breadcrumbs

  def new
    @record = @issue.records.build
    add_create_breadcrumbs
  end

  def create
    @record = @issue.records.build(record_params)

    if @record.save
      redirect_to @issue, notice: 'Work was successfully logged.'
    else
      add_create_breadcrumbs
      render :new
    end
  end

  def edit
    add_update_breadcrumbs
  end

  def update
    if @record.update(record_params)
      redirect_to @record.issue, notice: 'Work was successfully updated.'
    else
      add_update_breadcrumbs
      render :edit
    end
  end

  def destroy
    @record.destroy
    redirect_to @issue, notice: 'Record was successfully destroyed.'
  end

  private

  def set_issue
    @issue = Issue.find_by(id: params[:issue_id])
    redirect_to(projects_url, alert: 'Could not find Issue.') unless @issue
  end

  def set_record
    @record = Record.find_by(id: params[:id])

    if @record
      @record = @record.decorate
    else
      redirect_to(root_url, alert: 'Could not find Work.')
    end
  end

  def add_breadcrumbs
    issue = @issue || @record.issue
    project = issue.project
    add_breadcrumb t('breadcrumbs.projects.index'), projects_path
    add_breadcrumb project.name, project
    add_breadcrumb issue.title, issue
  end

  def add_create_breadcrumbs
    add_breadcrumb :create
  end

  def add_update_breadcrumbs
    add_breadcrumb :update
  end

  def record_params
    params.require(:record).permit(:worked, :worked_at)
  end
end
