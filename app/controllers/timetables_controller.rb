class TimetablesController < ApplicationController
  #load_and_authorize_resource

  def index
    @color_day_off = '#faf0e6'
    @current_date = set_date

    @soldiers = Soldier.all

    respond_to do |format|
      format.html
      format.csv { send_data export_csv, filename: "timetable_#{@current_date.year}_#{@current_date.month}.csv" }
      format.xls do
        headers['Content-disposition'] = "inline;  filename='timetable_#{@current_date.year}_#{@current_date.month}.xls'"
      end
    end
  end

  def new
    @lesson = Lesson.new
    @patrol = Patrol.new
  end

  def create
    if params[:patrol_present] == 'false'
      @lesson = Lesson.new(lesson_params)
      redirect_to timetables_path, notice: 'Post was successfully created.' and return if @lesson.save
    end

    if params[:patrol_present] == 'true'
      @patrol = Patrol.new(patrol_params)
      redirect_to timetables_path, notice: 'Post was successfully created.' and return if @patrol.save
    end

    redirect_to timetables_path, notice: 'Save ERROR'
  end

  def edit
    @lesson = Lesson.where(date: @lesson.date, soldier_id: @lesson.soldier_id).first
    @patrol = Patrol.where(patrol_start: @patrol.patrol_start, soldier_id: @patrol.soldier_id).first
  end

  def update
    value_name = params[:value_name]
    is_patrol = params[:patrol_present]

    if value_name == 'lesson' && is_patrol == 'false'
      @lesson = Lesson.find(params[:id])
      @lesson.attributes = lesson_params
      @lesson.save
      #redirect_to timetables_path, notice: 'Post was successfully update' if @lesson.save
    end

    if value_name == 'lesson' && is_patrol == 'true'
      @lesson = Lesson.find(params[:id])
      @lesson.destroy
      @patrol = Patrol.new(patrol_params)
      @patrol.save
      #redirect_to timetables_path, notice: 'Post was successfully update' if @patrol.save
    end

    if value_name == 'patrol' && is_patrol == 'true'
      @patrol = Patrol.find(params[:id])
      @patrol.attributes = patrol_params
      @patrol.save
      #redirect_to timetables_path, notice: 'Post was successfully update' if @patrol.save
    end

    if value_name == 'patrol' && is_patrol == 'false'
      @patrol = Patrol.find(params[:id])
      @patrol.destroy
      @lesson = Lesson.new(lesson_params)
      @lesson.save
      #redirect_to timetables_path, notice: 'Post was successfully update' if @lesson.save
    end

    redirect_to timetables_path
    #redirect_to timetables_path, notice: 'UPDATE ERROR' if @lesson.save
  end

  def destroy
    value_name = params[:value_name]
    if value_name == 'lesson'
      @lesson = Lesson.find(params[:id])
      @lesson.destroy
    end

    if value_name == 'patrol'
      @patrol = Patrol.find(params[:id])
      @patrol.destroy
    end

    redirect_to timetables_path
  end

  def ajax_load_form
    action = params[:action_name]
    @date = get_date
    @soldier_id = get_soldier_id

    if action == 'create'
      @lesson = Lesson.new
      @patrol = Patrol.new

      @lesson.soldier_id = @patrol.soldier_id = @soldier_id
      @lesson.date = @patrol.patrol_start = @date
      @patrol.patrol_end = @patrol.patrol_start + 1.day
    elsif action == 'edit'
      @lesson = Lesson.where(date: @date, soldier_id: @soldier_id).first
      @patrol = Patrol.where(patrol_start: @date, soldier_id: @soldier_id).first
    end

    render action: action, layout: false
  end

  private

  def set_date
    current_month = params[:month] || Date.current.month
    current_year = params[:year] || Date.current.year
    Date.new(current_year.to_i, current_month.to_i, 1)
  end

  def initialize_for_layout
    @current_tab = :timetables
  end

  def get_date
    DateTime.strptime(params[:date], '%Y-%m-%d')
  end

  def get_soldier_id
    params[:soldier_id].to_i
  end

  # =================================================================
  #   EXPORT CSV
  # =================================================================
  def export_csv
    date_mas = []
    date_mas << 'ФИО'
    1.upto @current_date.end_of_month.day do |day|
      date_mas << day.to_s
    end

    CSV.generate do |csv|
      # header row
      csv << date_mas
      # data row
      Soldier.all.each do |s|
        csv << mas_for_soldier_csv(@current_date, s)
      end
    end
  end

  def mas_for_soldier_csv(date, soldier)
    mas = []
    mas << soldier.surname + ' ' + soldier.name[0] + '.' + soldier.patronymic[0] + '.'
    1.upto date.end_of_month.day do |day|
      mas << state_of_cell_csv(date.beginning_of_month + day - 1, soldier.id)
    end
    mas
  end

  def state_of_cell_csv(date, soldier_id)
    lesson = Lesson.where(date: date, soldier_id: soldier_id).first
    patrol = Patrol.where(patrol_start: date, soldier_id: soldier_id).first
    return lesson.hours.to_s unless lesson.nil?
    return 'н' unless patrol.nil?
    nil
  end
  # =================================================================

  def lesson_params
    params.require(:lesson).permit(:hours, :date, :soldier_id)
  end

  def patrol_params
    params.require(:patrol).permit(:patrol_start, :patrol_end, :soldier_id)
  end
end