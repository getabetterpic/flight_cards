class LaunchesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_launch, only: %i[edit update]

  def new
    @launch = current_user.launches.new
  end

  def create
    @launch = current_user.launches.new(launch_params)
    if @launch.save
      redirect_to launches_path
    else
      render :new, alert: 'Something went wrong.'
    end
  end

  def edit; end

  def update
    if @launch.update(launch_params)
      redirect_to launches_path
    else
      render :edit, alert: 'Something went wrong.'
    end
  end

  def index
    @launches = current_user.launches
  end

  private

  def load_launch
    @launch = current_user.launches.find(params[:id])
  end

  def launch_params
    params.require(:launch).permit(:date, :name, :location)
  end
end
