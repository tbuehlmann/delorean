class ProjectDecorator < Draper::Decorator
  delegate_all

  def formatted_created_at
    h.time_ago(object.created_at)
  end

  def formatted_updated_at
    h.time_ago(object.updated_at)
  end
end
