class TimetableController < ApplicationController
  def index

  end

  private

  def initialize_for_layout
    @current_tab = :timetable
  end
end