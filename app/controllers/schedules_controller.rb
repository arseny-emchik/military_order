class SchedulesController < ApplicationController
  def edit
    @lesson = Lesson.find(params[:id])
    @patrol = Patrol.find(params[:id])
  end

  def update
    @lesson = Lesson.find(params[:id])
    @patrol = Patrol.find(params[:id])

    @lesson.attributes = lesson_params
    @patrol.attributes = patrol_params

    if @lesson.save && @patrol.save
      redirect_to soldiers_path, notice: 'Post was successfully update.'
    else
      render action: 'edit'
    end
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

  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy
    @patrol = Patrol.find(params[:id])
    @patrol.destroy
    redirect_to soldier_url, notice: 'Post was successfully destroyed.'
  end

  private

  def get_date
    DateTime.strptime(params[:date], '%Y-%m-%d')
  end

  def get_soldier_id
    params[:soldier_id].to_i
  end

  def lesson_params
    params.require(:lesson).permit(:hours, :date, :soldier_id)
  end

  def patrol_params
    params.require(:patrol).permit(:patrol_start, :patrol_end, :soldier_id)
  end
end