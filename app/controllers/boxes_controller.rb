class BoxesController < ApplicationController
  def create
    results = CreateBox.run(params)
    if results.success?
      respond_with results.box
    else
      respond_with results.error
    end
  end
end

