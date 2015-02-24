class FilesController < ApplicationController
  def create
    render(json: {}, status: 201)
  end
end
