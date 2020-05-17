class RootController < ApplicationController
  def index
    redirect_to launches_path if current_user
  end
end
