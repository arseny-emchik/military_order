class TimetablesController < ApplicationController
  def index

  end

  private

  def initialize_for_layout
    @current_tab = :timetables
  end
end