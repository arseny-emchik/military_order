module ApplicationHelper
  def count_lessons(date_start, date_end, soldier_id)
    date_end, date_start = date_start, date_end if date_start > date_end

    Lesson.where('date >= :start AND date <= :end AND soldier_id = :soldier_id',
                 start: date_start, end: date_end, soldier_id: soldier_id).sum(:hours)
  end

  def count_patrols(date_start, date_end, soldier_id)
    date_end, date_start = date_start, date_end if date_start > date_end

    f_count = Patrol.where('patrol_start >= :start AND patrol_start <= :end AND soldier_id = :soldier_id AND kind = :kind',
                 start: date_start, end: date_end, soldier_id: soldier_id, kind: 'ф').count
    y_count = Patrol.where('patrol_start >= :start AND patrol_start <= :end AND soldier_id = :soldier_id AND kind = :kind',
                 start: date_start, end: date_end, soldier_id: soldier_id, kind: 'у').count
    return f_count, y_count
  end

  # Friday - Saturday
  def count_patrols_fr_sat(date_start, date_end, soldier_id)
    date_end, date_start = date_start, date_end if date_start > date_end

    arr_date = []
    date_start.upto date_end do |day|
      current_date = date_start + (day - 1).day
      arr_date << current_date if current_date.friday?
    end

    (arr_date.empty?) ? 0 : Patrol.where('soldier_id = :soldier_id and patrol_start IN (:array)', array: arr_date, soldier_id: soldier_id).count
  end

  # Sunday -Monday
  def count_patrols_sun_mon(date_start, date_end, soldier_id)
    date_end, date_start = date_start, date_end if date_start > date_end

    arr_date = []
    date_start.upto date_end do |day|
      current_date = date_start + (day - 1).day
      arr_date << current_date if current_date.sunday?
    end

    (arr_date.empty?) ? 0 : Patrol.where('soldier_id = :soldier_id and patrol_start IN (:array)', array: arr_date, soldier_id: soldier_id).count
  end


  def get_percents(date_start, date_end, soldier_id)
    share_soldier = @current_date.end_of_month.day.to_f / Soldier.all.count.to_f
    f_patrols, y_patrols = count_patrols(date_start, date_end, soldier_id)
    result = (f_patrols + y_patrols) * 100.0 / share_soldier
    result > 100 ? '100%' : result.to_s + '%'
  end
end
