class HealthChecksController < ApplicationController
  skip_before_action :authenticate
  respond_to :json

  def show
    # Just hit the database to ensure it's up and running
    Resource.first
    # Return an empty hash because everything's GREAT
    render json: {}
  end
end