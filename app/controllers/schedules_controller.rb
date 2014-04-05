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
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @patrol = Patrol.new(patrol_params)

    if @lesson.save && @patrol.save
      redirect_to soldiers_url, notice: 'Post was successfully created.'
    else
      render action: 'new'
    end
  end

  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy
    @patrol = Patrol.find(params[:id])
    @patrol.destroy
    redirect_to soldier_url, notice: 'Post was successfully destroyed.'
  end

  private

  def lesson_params
    params.require(:lesson).permit(:hours, :date, :soldier_id)
  end

  def patrol_params
    params.require(:patrol).permit(:patrol_start, :patrol_end, :soldier_id )
  end
end