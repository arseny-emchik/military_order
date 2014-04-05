class SoldiersController < ApplicationController
  def index
    @soldiers = Soldier.all
  end

  def show
    @soldier = Soldier.find(params[:id])
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
    @soldier = Soldier.new(soldier_params)

    if @soldier.save
      redirect_to soldiers_url, notice: 'Post was successfully created.'
    else
      render action: 'new'
    end
  end

  def destroy
    @soldier = Soldier.find(params[:id])
    @soldier.destroy
    redirect_to soldier_url, notice: 'Post was successfully destroyed.'
  end

  private

  def soldier_params
    params.require(:soldier).permit(:surname, :name, :patronymic, :rank_id)
  end

  def initialize_for_layout
    @current_tab = :soldiers
  end
end