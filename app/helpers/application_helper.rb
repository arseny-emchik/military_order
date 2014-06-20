module ApplicationHelper
  # ================================================================
  # block of func for main_table
  # ================================================================
  def get_all_workdays(date_start, date_end)
    date_end, date_start = date_start, date_end if date_start > date_end

    lessons = Lesson.where('date >= :start AND date <= :end',
                           start: date_start, end: date_end)
    patrols = Patrol.where('patrol_end >= :start AND patrol_end <= :end',
                           start: date_start, end: date_end)
    return lessons, patrols
  end

  def det_solder_workdays(lessons, patrols, soldier_id)
    solder_lessons = []
    solder_patrols = []
    lessons.each { |l| solder_lessons << l if l[:soldier_id] == soldier_id }
    patrols.each { |p| solder_patrols << p if p[:soldier_id] == soldier_id }
    return solder_lessons, solder_patrols
  end

  def get_solder_lesson(date, lessons)
    lessons.each { |l| return l if l[:date] == date }
    nil
  end

  def get_solder_patrol(date, patrols)
    patrols.each { |p| return p if p[:patrol_end] == date }
    nil
  end

  # ================================================================

  def count_notreg_users
    User.all_available.not_registered.count
  end

  def count_lessons_by_date(date_start, date_end, soldier_id, lessons)
    date_end, date_start = date_start, date_end if date_start > date_end

    sum = 0
    lessons.each { |l| sum += l.hours if l.soldier_id == soldier_id }
    sum
  end

  def count_patrols_by_date(date_start, date_end, soldier_id, patrols)
    date_end, date_start = date_start, date_end if date_start > date_end

    f_count = 0
    y_count = 0
    patrols.each do |p|
      f_count += 1 if p.soldier_id == soldier_id && p.kind == 'ф'
      y_count += 1 if p.soldier_id == soldier_id && p.kind == 'у'
    end

    return f_count, y_count
  end

  def count_patrols_by_day(date_start, date_end, soldier_id, type_last_day, patrols)
    date_end, date_start = date_start, date_end if date_start > date_end

    arr_date = []
    date_start.upto date_end do |day|
      current_date = date_start + (day - 1).day
      arr_date << current_date if this_type_day?(type_last_day, current_date)
    end

    f_count = 0
    y_count = 0
    patrols.each do |p|
      f_count += 1 if p.soldier_id == soldier_id && p.kind == 'ф' && arr_date.include?(p.patrol_end)
      y_count += 1 if p.soldier_id == soldier_id && p.kind == 'у' && arr_date.include?(p.patrol_end)
    end

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

  def count_patrols_by_celebrations(date_start, date_end, soldier_id, patrols)
    date_end, date_start = date_start, date_end if date_start > date_end

    f_count = 0
    y_count = 0
    patrols.each do |p|
      f_count += 1 if p.soldier_id == soldier_id && p.kind == 'ф' && Celebrations.is_in?(p.patrol_end.month, p.patrol_end.day)
      y_count += 1 if p.soldier_id == soldier_id && p.kind == 'у' && Celebrations.is_in?(p.patrol_end.month, p.patrol_end.day)
    end

    return f_count, y_count
  end

  def get_percents(date_start, date_end, soldier_id, patrols)
    share_soldier = @current_date.end_of_month.day.to_f / Soldier.all.count.to_f
    f_patrols, y_patrols = count_patrols_by_date(date_start, date_end, soldier_id, patrols)
    result = (f_patrols + y_patrols) * 100.0 / share_soldier
    result > 100 ? '100%' : result.to_s + '%'
  end


  def popup_win
    content_tag(:small, style: "float: right") do
      content_tag(:a, href: "#{request.protocol}#{request.host_with_port}/settings", id: "popup", rel: 'popover', style: "color: red") do
        ('<span class="glyphicon glyphicon-exclamation-sign"></span>').html_safe
      end
    end
  end
end
