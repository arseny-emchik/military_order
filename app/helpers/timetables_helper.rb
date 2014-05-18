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
      return "<Cell><Data ss:Type='String'>#{ch}</Data></Cell>".html_safe
    end

    content_tag(tag, style: "background-color: #{color}", data: {action: action, date: date.to_s, soldier_id: soldier_id}) do
      ch
    end

  end

  def soldiers_sort
    Soldier.sort_by_patrols('asc')
  end

  def kind_of_action(action)
    return 'Новая запись' if action == 'create'
    return 'Редактировнае записи' if action == 'update'
    'Неизвестный action!! ERROR'
  end

  def show_info(date, soldier_id)
    content_tag(:h4, "Фамилия: #{Soldier.find(soldier_id).surname}") +
        content_tag(:h4, "Дата: #{Russian.strftime(date, '%A %d.%m.%Y').mb_chars.downcase}")
  end

  def method_name(action_name)
    action_name == 'update' ? 'PUT' : 'POST'
  end

  def get_value_name
    return 'lesson' if @lesson
    return 'patrol' if @patrol
    nil
  end
end
