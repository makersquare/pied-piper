class FieldsController < ApplicationController
  respond_to :json

  # def create
  #   # Create a new, empty box with the create_box TXS
  #   results = CreateBox.run(box_params)
  #   if results.success?
  #     respond_with results.box
  #   else
  #     respond_with results.error
  #   end
  # end

  def destroy
    respond_with Field.destroy(params['id']).to_json
  end

  def index
    # Index to show boxes and create new boxes
    respond_with Field.where(pipeline_id: params["pipeline_id"]).to_json
  end

  def create
    # User can create new box fields
    field = Field.create(pipeline_id: field_params['pipeline_id'],
      field_name: field_params['field_name'],
      field_type: field_params['field_type'])
    respond_with(field.to_json, status: :created,
      location: pipeline_field_path(id: field.id, pipeline_id: field.pipeline_id))
  end

  private

  # def box_params
  #   # All params currently permitted
  #   params.permit(:id, :contact_id, :pipeline_id, :stage_id, :pipeline_location, :format)
  # end

  def field_params
    # All params currently permitted
    params.permit(:id, :pipeline_id, :field_type, :field_name, :format, :field)
  end

  # def box_field_params
  #   # All params currently permitted
  #   params.permit(:id, :field_id, :box_id, :value)
  # end
end

