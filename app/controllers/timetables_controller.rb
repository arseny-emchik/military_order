class TimetablesController < ApplicationController
  def index
    @color_day_off = '#faf0e6'
    @current_month = Date.current.month
    @current_year = Date.current.year
    @soldiers = Soldier.all
  end

  private

  def initialize_for_layout
    @current_tab = :timetables
  end
end