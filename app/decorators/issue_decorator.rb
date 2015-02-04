class IssueDecorator < Draper::Decorator
  delegate_all

  def status_action
    case object.status
    when 'open'
      h.link_to(h.fa_icon('square-o'), h.close_issue_path(object), method: :patch, remote: true, title: 'Close Issue', class: 'has-tooltip')
    when 'closed'
      h.link_to(h.fa_icon('check-square-o'), h.open_issue_path(object), method: :patch, remote: true, title: 'Open Issue', class: 'has-tooltip')
    end
  end

  def formatted_worked
    h.distance_of_time(object.worked.minutes)
  end

  def formatted_created_at
    h.time_ago(object.created_at)
  end

  def formatted_updated_at
    h.time_ago(object.updated_at)
  end
end
