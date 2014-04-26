class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  Russian.init_i18n

  before_action :authenticate_user!
  layout :layout_by_resource
  before_filter :initialize_for_layout, except: [:new, :edit]

  private

  def initialize_for_layout
  end

  def layout_by_resource
    if devise_controller?
      'device'
    else
      'main_view'
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    timetables_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

end
