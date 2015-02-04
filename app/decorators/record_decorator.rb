class RecordDecorator < Draper::Decorator
  delegate_all

  def formatted_worked
    h.distance_of_time(object.worked.minutes)
  end

  def formatted_worked_at
    object.worked_at.strftime('%F')
  end
end
