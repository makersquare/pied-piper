# This script takes an input of a query to be searched for
# It's results will consist of 5 potential matches
# 1. A pipeline matches with it's name
# 2. A Stage in a pipeline matches with it's name
# 3. A field for a pipeline matches
# 4. A contact's information matches
# 5. The value for a contact's box field matches
class GetSearchResults < TransactionScript
  def run(params)
    @search_term = params[:query]

    # If no term is given, error out
    if @search_term.nil? || @search_term == ""
      return failure(:no_query_given)
    end

    # Grab the different components that could
    #   be a result of the search
    search_results = {
      pipelines: find_pipelines,
      stages: find_stages,
      fields: find_fields,
      contacts: find_contacts,
      boxes: find_boxes
    }

    success(search_results: search_results)
  end

  def find_pipelines
    pipelines = Pipeline.where("name ILIKE :search", search: "%#{@search_term}%")
  end

  def find_fields
    # Grabs the matching fields and sends the matching pipeline
    #   with it.
    fields = Field.includes(:pipeline).where("field_name ILIKE :search", search: "%#{@search_term}%")
    fields.map do |field|
      res = field.serializable_hash
      res["pipeline"] = field.pipeline
      res
    end
  end

  def find_stages
    # Grabs the matching stages and sends the matching pipeline
    #   with it.
    stages = Stage.includes(:pipeline).where("name ILIKE :search", search: "%#{@search_term}%")
    stages.map do |stage|
      res = stage.serializable_hash
      res["pipeline"] = stage.pipeline
      res
    end
  end

  def find_contacts
    # Finds contacts that may match by email or name
    contacts = Contact.where("name ILIKE :search", search: "%#{@search_term}%")
    contacts += Contact.where("email ILIKE :search", search: "%#{@search_term}%")
  end

  def find_boxes
    # Finds matches by value of boxFields. It will put together
    #   The contact, pipeline, field value and field name.
    box_fields = BoxField.includes(box: [:contact, :pipeline], field: []).where("value ILIKE :search", search: "%#{@search_term}%")
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