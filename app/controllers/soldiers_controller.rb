class SoldiersController < ApplicationController
  load_and_authorize_resource param_method: :soldier_params

  def index
    @date_start = get_date('date_start')
    @date_end = get_date('date_end')
    @date_start, @date_end = @date_end, @date_start if @date_start > @date_end

    @soldiers = Soldier.all
  end

  def edit
    @soldier = Soldier.find(params[:id])
  end

  def update
    @soldier = Soldier.find(params[:id])
    @soldier.attributes = soldier_params

    if @soldier.save
      redirect_to soldiers_path, notice: 'Post was successfully update.'
    else
      render action: 'edit'
    end
  end

  def new
    @soldier = Soldier.new
  end

  def create
    @soldier = Soldier.new
    @soldier.attributes = soldier_params

    if @soldier.save
      redirect_to soldiers_url, notice: 'Post was successfully created.'
    else
      render action: 'new'
    end
  end

  def destroy
    @soldier = Soldier.find(params[:id])
    @soldier.destroy
    redirect_to soldiers_url, notice: 'Post was successfully destroyed.'
  end

  private

  def get_date(value_name)
    return DateTime.strptime(params[value_name], '%d.%m.%Y') unless params[value_name].nil? || params[value_name].empty?
    value_name == 'date_start' ? Date.current.beginning_of_month : Date.current.end_of_month
  end

  def soldier_params
    params.require(:soldier).permit(:surname, :name, :patronymic, :rank_id)
  end

  def initialize_for_layout
    @current_tab = :soldiers
  end
end