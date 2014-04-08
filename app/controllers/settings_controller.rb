class SettingsController < ApplicationController

  def index

  end

  private

  def initialize_for_layout
    @current_tab = :settings
  end
end