class RootController < ApplicationController
  # Lists API endpoints available to the current_user
  def index
    render json: {}
  end
end
