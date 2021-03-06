#
# This constructs a object to be sent to the client with with detailed information
# about the contact that are part of a given pipeline.  This information includes two types
# Basic and Complex.
# Basic Information comes from the: Contacts Table
# Complex Information comes from: Boxes, BoxFields, Fields Tables
#
# Example Script Call
#   RetrieveBoxesForPipeline.run(pipeline_id: 7)
# Example Output
#   Returns OStruct, for ease of use.
#   { success?: true,
#     contacts: [
#       { name: "Doug",
#         email: "doug@doug.com",
#         id: "7",
#         stage_id: "16"
#         'field1_name' : field1_value,
#         'fieldn_name': fieldn_value,
#         ...more fields...
#        },
#         ...Another Contact...
#     ]
#   }

class RetrieveBoxesForPipeline < TransactionScript
  def run(params)
    pipeline_id = params[:pipeline_id]

    if pipeline_id.nil? || pipeline_id == ""
      return failure(:no_pipeline_given)
    end

    pipeline = Pipeline.where(id: pipeline_id).first

    if pipeline.nil?
      return failure(:invalid_pipeline_id)
    end

    fields = retrieve_fields(pipeline)
    # Returning each contact's information
    # Gathering - basic info, stage_id, fields
    contacts = pipeline.boxes.map do |box|
      contact = box.contact
      # Convert to OpenStruct for ease of use
      contact = OpenStruct.new(contact.serializable_hash)
      contact.stage_id = box.stage_id
      add_fields_to_contact(contact, fields, box)
      contact
    end
    success(contacts: contacts)
  end

  def retrieve_fields(pipeline)
    pipeline.fields
  end

  def add_fields_to_contact(contact, fields, box)
    fields.each do |field|
      box_field = BoxField.where(field_id: field.id, box_id: box.id).first
      box_field.nil? ? value = "" : value = box_field.value
      contact[field.field_name] = value
    end
  end

  # Retrieves information about which pipelines the contact is in.
  def add_pipeline_info_to_contact(contact, contact_struct)
    pipelines = contact.pipelines
    contact_struct.pipelines = pipelines.to_a.map(&:serializable_hash)
  end
end
