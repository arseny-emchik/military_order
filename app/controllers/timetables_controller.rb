class TimetablesController < ApplicationController
  def index
    @color_day_off = '#faf0e6'
    @current_date = set_date

    @soldiers = Soldier.all
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
end