class HealthChecksController < ApplicationController
  respond_to :json

  def show
    Resource.first
    render json: {}
  end
end
