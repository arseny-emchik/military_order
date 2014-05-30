module TimetablesHelper
  def state_of_cell(tag, date, soldier_id)
    lesson = Lesson.where(date: date, soldier_id: soldier_id).limit(1).first
    patrol = Patrol.where(patrol_end: date, soldier_id: soldier_id).limit(1).first

    if can? [:create, :update], [Patrol, Lesson]
      action = (patrol.nil? && lesson.nil?) ? 'n' : 'e' # n - new; e - edit
    else
      action = 'nothing'
    end

    id = ''
    ch = nil
    ch = patrol.kind unless patrol.nil?
    ch = lesson.hours.to_s unless lesson.nil?

    if date.saturday? || date.sunday? || Celebrations.is_in?(date.month, date.day)
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

  def state_of_day_cell(tag, day)
    color = '#ffffff'

    date = @current_date.beginning_of_month + (day - 1)
    count_patrols = Patrol.where(patrol_end: date).count

    color = '#fdeaa8' if count_patrols == 0 #&& date.sunday? #now without day off

    content_tag(tag, style: "background-color: #{color}") do
      day.to_s
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
