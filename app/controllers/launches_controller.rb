class LaunchesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_launch, only: %i[edit update]

  rescue_from Pundit::NotAuthorizedError do
    redirect_to launches_path, alert: I18n.t('unauthorized_error')
  end

  def new
    @launch = current_user.launches.new
    authorize @launch
  end

  def create
    @launch = current_user.launches.new(launch_params)
    authorize @launch
    if @launch.save
      redirect_to launches_path
    else
      render :new, alert: 'Something went wrong.'
    end
  end

  def edit
    authorize @launch
  end

  def update
    authorize @launch
    if @launch.update(launch_params)
      redirect_to launches_path
    else
      render :edit, alert: 'Something went wrong.'
    end
  end

  def index
    @launches = Launch.all
  end

  private

  def load_launch
    @launch = Launch.find(params[:id])
  end

  def launch_params
    params.require(:launch).permit(:date, :name, :location, :lco, :rso)
  end
end
