class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  Russian.init_i18n

  layout :layout_by_resource
  before_filter :initialize_for_layout, except: [:new]

  private

  def initialize_for_layout
  end
  def layout_by_resource
    'main_view' #unless devise_controller?
  end
end
