module TimetablesHelper
  def state_of_cell_l(tag, data, soldier_id)
    content_tag(tag, "data-action = 'n', date = #{current_day}, soldier_id = #{s.id}") do
      lesson = Lesson.where(date: data, soldier_id: soldier_id).first
      patrol = Patrol.where(patrol_start: data, soldier_id: soldier_id).first

      return 'n' unless patrol.nil? #link_to 'н',controller: 'schedules', action: 'new', date: data, soldier_id: soldier_id  unless patrol.nil?
      return lesson.hours unless lesson.nil? #link_to lesson.hours, controller: 'schedules', action: 'new', date: data, soldier_id: soldier_id  unless lesson.nil?
      'e' #link_to 'e', controller: 'schedules', action: 'new', date: data, soldier_id: soldier_id
    end
  end


  def state_of_cell(tag, date, soldier_id)
    lesson = Lesson.where(date: date, soldier_id: soldier_id).first
    patrol = Patrol.where(patrol_start: date, soldier_id: soldier_id).first

    action = (patrol.nil? && lesson.nil?) ? 'n' : 'e'  # n - new; e - edit

    if action == 'n'
      color = '#faf0e6'
    elsif date.saturday? || date.sunday?
      color = '#f5f5dc'
    else
      color = '#ffffff'
    end

    str = "data-action = #{action}, date = #{date}, soldier_id = #{soldier_id} style='background-color: #{color}'"

    content_tag(tag, str) do
      lesson.hours unless lesson.nil?
      'n' unless patrol.nil?
    end
  end
end
