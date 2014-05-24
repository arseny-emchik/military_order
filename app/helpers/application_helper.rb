module ApplicationHelper
  def count_lessons_by_date(date_start, date_end, soldier_id)
    date_end, date_start = date_start, date_end if date_start > date_end

    Lesson.where('date >= :start AND date <= :end AND soldier_id = :soldier_id',
                 start: date_start, end: date_end, soldier_id: soldier_id).sum(:hours)
  end

  def count_patrols_by_date(date_start, date_end, soldier_id)
    date_end, date_start = date_start, date_end if date_start > date_end

    f_count = Patrol.where('patrol_end >= :start AND patrol_end <= :end AND soldier_id = :soldier_id AND kind = :kind',
                           start: date_start, end: date_end, soldier_id: soldier_id, kind: 'ф').count
    y_count = Patrol.where('patrol_end >= :start AND patrol_end <= :end AND soldier_id = :soldier_id AND kind = :kind',
                           start: date_start, end: date_end, soldier_id: soldier_id, kind: 'у').count
    return f_count, y_count
  end

  def count_patrols_by_day(date_start, date_end, soldier_id, type_last_day)
    date_end, date_start = date_start, date_end if date_start > date_end

    arr_date = []
    date_start.upto date_end do |day|
      current_date = date_start + (day - 1).day
      arr_date << current_date if this_type_day?(type_last_day, current_date)
    end

    f_count = (arr_date.empty?) ? 0 : Patrol.where('soldier_id = :soldier_id AND kind = :kind AND patrol_end IN (:array)', array: arr_date, soldier_id: soldier_id, kind: 'ф').count
    y_count = (arr_date.empty?) ? 0 : Patrol.where('soldier_id = :soldier_id AND kind = :kind AND patrol_end IN (:array)', array: arr_date, soldier_id: soldier_id, kind: 'у').count
    return f_count, y_count
  end

  # method for count patrols by day
  def this_type_day?(type_day, current_day)
    type_day.to_sym
    result = case (type_day)
               when :monday then
                 current_day.monday?
               when :tuesday then
                 current_day.tuesday?
               when :wednesday then
                 current_day.wednesday?
               when :thursday then
                 current_day.thursday?
               when :friday then
                 current_day.friday?
               when :saturday then
                 current_day.saturday?
               when :sunday then
                 current_day.sunday?
               else
                 false
             end
  end

  def count_patrols_by_celebrations(date_start, date_end, soldier_id)
    date_end, date_start = date_start, date_end if date_start > date_end

    all_patrols_f = Patrol.where('patrol_end >= :start AND patrol_end <= :end AND soldier_id = :soldier_id AND kind = :kind',
                               start: date_start, end: date_end, soldier_id: soldier_id, kind: 'ф')
    all_patrols_y = Patrol.where('patrol_end >= :start AND patrol_end <= :end AND soldier_id = :soldier_id AND kind = :kind',
                                 start: date_start, end: date_end, soldier_id: soldier_id, kind: 'у')

    count_f = 0
    all_patrols_f.each do |f|
      count_f += 1 if Celebrations.is_in?(f.patrol_end.month, f.patrol_end.day)
    end

    count_y = 0
    all_patrols_y.each do |y|
      count_y += 1 if Celebrations.is_in?(y.patrol_end.month, y.patrol_end.day)
    end

    return count_f, count_y
  end

  def get_percents(date_start, date_end, soldier_id)
    share_soldier = @current_date.end_of_month.day.to_f / Soldier.all.count.to_f
    f_patrols, y_patrols = count_patrols_by_date(date_start, date_end, soldier_id)
    result = (f_patrols + y_patrols) * 100.0 / share_soldier
    result > 100 ? '100%' : result.to_s + '%'
  end
end
