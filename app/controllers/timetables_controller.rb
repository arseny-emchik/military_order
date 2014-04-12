class TimetablesController < ApplicationController

  SPAN_YEARS = 5.freeze

  def index
    @color_day_off = '#faf0e6'
    @current_date = set_date

    @soldiers = Soldier.all
  end

  def new
    @lesson = Lesson.new
    @patrol = Patrol.new

    @lesson.soldier_id = @patrol.soldier_id = get_soldier_id
    @lesson.date = @patrol.patrol_start = get_date
    @patrol.patrol_end = @patrol.patrol_start + 1.day
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

  def ajax_load_form
    @lesson = Lesson.new
    @patrol = Patrol.new

    @lesson.soldier_id = @patrol.soldier_id = get_soldier_id
    @lesson.date = @patrol.patrol_start = get_date
    @patrol.patrol_end = @patrol.patrol_start + 1.day

    render partial: 'timetables/form', locals: {action_name: :new}
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

end