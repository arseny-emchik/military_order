module ApplicationHelper
  def count_lessons(date_start, date_end, soldier_id)
    date_end, date_start = date_start, date_end if date_start > date_end

    Lesson.where('date >= :start AND date <= :end AND soldier_id = :soldier_id',
                 start: date_start, end: date_end, soldier_id: soldier_id).sum(:hours)
  end

  def count_patrols(date_start, date_end, soldier_id)
    date_end, date_start = date_start, date_end if date_start > date_end

    Patrol.where('patrol_start >= :start AND patrol_start <= :end AND soldier_id = :soldier_id',
                 start: date_start, end: date_end, soldier_id: soldier_id).count
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

  # Saturday - Sunday
  def count_patrols_sat_sun(date_start, date_end, soldier_id)
    date_end, date_start = date_start, date_end if date_start > date_end

    arr_date = []
    date_start.upto date_end do |day|
      current_date = date_start + (day - 1).day
      arr_date << current_date if current_date.saturday?
    end

    (arr_date.empty?) ? 0 : Patrol.where('soldier_id = :soldier_id and patrol_start IN (:array)', array: arr_date, soldier_id: soldier_id).count
  end


  def get_percents(date_start, date_end, soldier_id)
    share_soldier = @current_date.end_of_month.day.to_f / Soldier.all.count.to_f
    result = count_patrols(date_start, date_end, soldier_id) * 100.0 / share_soldier
    result > 100 ? '100%' : result.to_s + '%'
  end
end
