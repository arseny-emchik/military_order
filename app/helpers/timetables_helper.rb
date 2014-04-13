module TimetablesHelper
  def state_of_cell(tag, date, soldier_id)
    lesson = Lesson.where(date: date, soldier_id: soldier_id).first
    patrol = Patrol.where(patrol_start: date, soldier_id: soldier_id).first

    action = (patrol.nil? && lesson.nil?) ? 'n' : 'e' # n - new; e - edit

    if date.saturday? || date.sunday?
      color = '#faf0e6'
    elsif action == 'e'
      color = '#f5f5dc'
    else
      color = '#ffffff'
    end

    content_tag(tag, style: "background-color: #{color}", data: {action: action, date: date.to_s, soldier_id: soldier_id}) do
      ch = 'н' unless patrol.nil?
      ch = lesson.hours.to_s unless lesson.nil?
      ch
    end
  end
end
