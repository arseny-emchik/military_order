module TimetablesHelper
  def state_of_cell(data, soldier_id)
    lesson = Lesson.where(date: data, soldier_id: soldier_id).first
    patrol = Patrol.where(patrol_start: data, soldier_id: soldier_id).first

    return link_to 'н',controller: 'schedules', action: 'new', date: data, soldier_id: soldier_id  unless patrol.nil?
    return link_to lesson.hours, controller: 'schedules', action: 'new', date: data, soldier_id: soldier_id  unless lesson.nil?
    link_to 'e', controller: 'schedules', action: 'new', date: data, soldier_id: soldier_id
  end
end