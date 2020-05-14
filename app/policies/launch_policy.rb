class LaunchPolicy < ApplicationPolicy
  attr_reader :user, :launch

  def initialize(user, launch)
    @user = user
    @launch = launch
  end

  def index?
    user.present?
  end

  def create?
    user&.launch_admin?
  end

  def update?
    create? && launch.admin == user
  end
end
