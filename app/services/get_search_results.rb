class GetSearchResults < TransactionScript
  def run(params)
    @search_term = params[:query]

    if @search_term.nil? || @search_term == ""
      return failure(:no_query_given)
    end

    search_results = {
      pipelines: find_pipelines,
      stages: find_stages,
      pipelines_by_field: find_pipelines_by_field,
      contacts: find_contacts,
      boxes: find_boxes
    }

    success(search_results: search_results)
  end

  def find_pipelines
    pipelines = Pipeline.where(name: @search_term) || []
  end

  def find_pipelines_by_field
    pipelines = Pipeline.joins(:fields).where(fields: {field_name: @search_term}) || []
  end

  def find_stages
    stages = Stage.where(name: @search_term) || []
  end

  def find_contacts
    contacts = Contact.where(name: @search_term) || []
    contacts += Contact.where(email: @search_term)
  end

  def find_boxes
    box_fields = BoxField.includes(box: [:contact, :pipeline], field: []).where(value: @search_term)
    box_fields.map do |box_field|
      box = box_field.box
      {
        field: {
          value: box_field.value,
          field_name: box_field.field.field_name
        },
        contact: box.contact,
        pipeline: box.pipeline
      }
    end
  end
end