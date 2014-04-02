class SoldierController < ApplicationController
  def index
    @solders = Soldier.all
  end

  def show
    @solder = Soldier.find(params[:id])
  end

  def edit
    @solder = Soldier.find(params[:id])
  end

  def update
    @solder = Soldier.find(params[:id])

    if @solder.save
      redirect_to soldier_url, notice: 'Post was successfully update.'
    else
      render action: 'edit'
    end
  end

  def new
    @solder = Soldier.new
  end

  def create
    @solder = Soldier.new(post_params)

    if @solder.save
      redirect_to soldier_url, notice: 'Post was successfully created.'
    else
      render action: 'new'
    end
  end

  def destroy
    @solder = Soldier.find(params[:id])
    @solder.destroy
    redirect_to soldier_url, notice: 'Post was successfully destroyed.'
  end

  private

  def post_params
    params.require(:post).permit(:surname, :name, :patronymic)
  end

  def initialize_for_layout
    @current_tab = :soldiers
  end
end