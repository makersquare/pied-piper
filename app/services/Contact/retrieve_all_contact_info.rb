# Retrieves all contacts from databases, but also
# injects data about which pipelines the contact is
# a part of.

class RetrieveAllContactInfo < TransactionScript
  def run(params)
    # Gather all contact information, but also send data about the pipelines
    contacts = Contact.all.map do |contact|
      # Convert to OpenStruct for ease of use
      contact_struct = OpenStruct.new(contact.serializable_hash)
      add_pipeline_info_to_contact(contact, contact_struct)
      contact_struct
    end

    return success(contacts: contacts)
  end

  # Retrieves information about which pipelines the contact is in.
  def add_pipeline_info_to_contact(contact, contact_struct)
    pipelines = contact.pipelines
    contact_struct.pipelines = pipelines.to_a.map(&:serializable_hash)
  end
end
