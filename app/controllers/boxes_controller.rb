class BoxesController < ApplicationController
  respond_to :json, :html
  # before_filter :logged_in?
  # before_filter :admin?

  def create
    # Create a new, empty box with the create_box TXS
    results = CreateBox.run(box_params)
    if results.success?
      respond_with results.box
    else
      respond_with results.error
    end
  end

  def show
    # Show a box given the box id
    show_box = Box.find(params[:id])
    respond_with show_box
  end

  def index
    # Index to show boxes and create new boxes
    respond_with Box.all.to_json
  end

  def update
    # User can create new box fields
    respond_with Field.create(params)
  end

  private

  def box_params
    # All params currently permitted
    params.permit(:id, :contact_id, :pipeline_id, :stage_id, :pipeline_location, :format)
  end

  def field_params
    # All params currently permitted
    params.permit(:id, :pipeline_id, :type, :field_name)
  end

  def box_field_params
    # All params currently permitted
    params.permit(:id, :field_id, :box_id, :value)
  end
end

