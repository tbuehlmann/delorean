module ApplicationHelper
  def time_ago(time)
    if time
      content_tag :time, time.strftime('%F %R'), class: 'timeago', datetime: time
    end
  end
end
