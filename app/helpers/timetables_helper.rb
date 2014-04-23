module TimetablesHelper
  def state_of_cell(tag, date, soldier_id)
    lesson = Lesson.where(date: date, soldier_id: soldier_id).first
    patrol = Patrol.where(patrol_start: date, soldier_id: soldier_id).first

    action = (patrol.nil? && lesson.nil?) ? 'n' : 'e' # n - new; e - edit

    id = ''
    ch = nil
    ch = 'н' unless patrol.nil?
    ch = lesson.hours.to_s unless lesson.nil?

    if date.saturday? || date.sunday?
      color = '#faf0e6'
      #id = 'day_off'  # added color for day off
    elsif action == 'e'
      color = '#f5f5dc'
    else
      color = '#ffffff'
    end

    if tag == :cell
      return "<Cell ss:StyleID='#{id}'><Data ss:Type='String'>#{ch}</Data></Cell>".html_safe
    end

    content_tag(tag, style: "background-color: #{color}", data: {action: action, date: date.to_s, soldier_id: soldier_id}) do
      ch
    end

  end

  def soldiers_sort
    Soldier.min_patrols
  end

  def kind_of_action(action)
    action == 'create' ? 'Новая запись' : 'Редактировнае записи'
  end

  def show_info(data, soldier_id)
      content_tag(:h4, "Фамилия: #{Soldier.find(soldier_id).surname}") +
      content_tag(:h4, "Дата: #{Russian.strftime(data, '%A %D').mb_chars.downcase}")
  end
end
