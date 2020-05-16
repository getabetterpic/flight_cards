class RootController < ApplicationController
  def index
    if current_user && current_user.role == 'flier'
      redirect_to launches_path
    end
  end
end
